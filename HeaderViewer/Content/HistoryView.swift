//
//  HistoryView.swift
//  HeaderViewer
    

import SwiftUI

 
struct HistoryView: View {
    @EnvironmentObject private var manager: HistoryManager
    @ObservedObject private var settingsManager = SettingsManager.shared
    
    
    var body: some View {
        NavigationStack {
            List {
                if manager.isHistoryEmpty {
                    Section { historyStatusView }
                }
                
                ForEach(manager.historyItems) { obj in
                    NavigationLink {
                        
                        RuntimeObjectDetail(type: obj)
                    } label: {
                        RuntimeObjectRow(type: obj)
                    }
                }
                .onDelete(perform: manager.removeObject)
            }
            .onAppear(perform: manager.refreshHistory)
            .navigationBarTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if !manager.isHistoryEmpty {
                        HistoryClearButton()
                    }
                }
            }
            .if(!manager.isHistoryEmpty) {
                $0.refreshable {
                    manager.refreshHistory()
                }
            }
        }
        .if(settingsManager.preferences.historyBadgeEnabled) {
            $0.badge(manager.historyCount)
        }
        .animation(.default, value: manager.historyItems) // Animate "onDelete" action
    }
    
    
    @ViewBuilder
    private var historyStatusView: some View {
        if settingsManager.preferences.historyEnabled {
            Label("No History Yet", systemImage: "clock.arrow.circlepath")
                .labelStyle(HistoryStatusLabelStyle(.flora, info: "Explore new objects to see them here."))
        } else {
            Label("History Disabled", systemImage: "exclamationmark.lock.fill")
                .labelStyle(
                    HistoryStatusLabelStyle(
                        .orange,
                        secondary: .white,
                        info: "You can enable it from settings."
                    )
                )
        }
    }
}

struct HistoryClearButton: View {
    @State private var showConfirmation: Bool = false
    @EnvironmentObject private var manager: HistoryManager
    
    var body: some View {
        Button(action: { showConfirmation.toggle() }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.secondary)
                .symbolRenderingMode(.hierarchical)
        }
        .buttonStyle(.plain)
        .confirmationDialog("", isPresented: $showConfirmation) {
            Button("Clear", role: .destructive, action: manager.clearHistory)
        }
    }
}

fileprivate struct HistoryStatusLabelStyle: LabelStyle {
    private let foreground: Color
    private let secondary: Color
    private let extraInfo: String
    
    init(_ foreground: Color, secondary: Color = .primary, info: String) {
        self.foreground = foreground
        self.secondary = secondary
        self.extraInfo = info
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 14) {
            configuration.icon
                .foregroundStyle(secondary, foreground.gradient)
                .font(.largeTitle)
                .symbolRenderingMode(.palette)
                .shadow(color: foreground, radius: 45)
            
            VStack(spacing: 5) {
                configuration.title
                    .font(.title2.weight(.bold))
                
                Text(extraInfo)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
}
