//
//  SettingsView.swift
//  HeaderViewer
    

import SwiftUI


struct SettingsView: View {
    @ObservedObject private var manager: SettingsManager = .shared
    @EnvironmentObject private var historyManager: HistoryManager
    
    @State private var showAppearancePopover: Bool = false
    @State private var showCodeAppearanceCover: Bool = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button("App Appearance", image: .appearanceLuminosity) {
                        showAppearancePopover.toggle()
                    }
                    .popover(isPresented: $showAppearancePopover, content: AppearancePopoverView.init)
                    .labelStyle(IconicLabelStyle(Color(red: 0.937255, green: 0.596078, blue: 0.419608)))
                    
                    Button {
                        showCodeAppearanceCover = true
                    } label: {
                        Label("Code Appearance", systemImage: "ellipsis.curlybraces")
                            .labelStyle(IconicLabelStyle(.orchid))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 1.5)
                
                Section {
                    Toggle(
                        "History Enabled",
                        systemImage: "clock.arrow.circlepath",
                        isOn: $manager.settings.historyEnabled.animation()
                    )
                    .labelStyle(IconicLabelStyle(Color(red: 0.92549, green: 0.411765, blue: 0.505882)))
                    
                    if manager.settings.historyEnabled {
                        Toggle(
                            "Badge Enabled",
                            image: .dotsNeedleBottom100Percent,
                            isOn: $manager.settings.historyBadgeEnabled.animation()
                        )
                        .labelStyle(IconicLabelStyle(Color(red: 0.352941, green: 0.619608, blue: 0.729412)))
                        
                        Stepper(value: $manager.settings.historyLimit.animation(), in: 0...100, step: 10) {
                            let limit = manager.settings.historyLimit == 0 ? "Unlimited" : String(manager.settings.historyLimit)
                            
                            HStack(spacing: 0) {
                                Label("Limit: ", systemImage: "number")
                                    .labelStyle(IconicLabelStyle(Color(red: 0.486275, green: 0.427451, blue: 0.917647)))
                                
                                Text(limit)
                                    .foregroundStyle(.gray)
                                    .font(.callout)
                                    .contentTransition(.numericText())
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("History")
                        Spacer()
                        if !historyManager.isHistoryEmpty {
                            HistoryClearButton()
                                .imageScale(.large)
                        }
                    }
                }
                .padding(.vertical, 1.5)
                
                
                CacheSection()
            }
            .buttonStyle(.plain)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .fullScreenCover(isPresented: $showCodeAppearanceCover, content: CodeAppearanceView.init)
        }
    }
}

struct CacheSection: View {
    @ObservedObject private var manager: SettingsManager = .shared
    @State private var showCacheClearConfirmation: Bool = false
    
    var body: some View {
        Section {
            Button {
                showCacheClearConfirmation.toggle()
            } label: {
                LabeledContent {
                    Text(manager.cacheSize)
                } label: {
                    Label("Cache Size", systemImage: "bubbles.and.sparkles.fill")
                        .labelStyle(IconicLabelStyle(Color(red: 0.384314, green: 0.717647, blue: 0.490196)))
                }
            }
        }
        .padding(.vertical, 1)
        .onAppear(perform: manager.calculateCacheSize)
        .confirmationDialog("", isPresented: $showCacheClearConfirmation) {
            Button("Clear", role: .destructive, action: manager.clearCache)
        }
    }
}
