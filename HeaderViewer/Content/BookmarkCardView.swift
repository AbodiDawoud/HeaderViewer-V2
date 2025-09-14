//
//  BookmarkRowView.swift
//  InternalSFSymbols
    

import SwiftUI

struct BookmarkCardView: View {
    private let symbolName: String = "book.square.stack.fill"
    @Environment(\.colorScheme) private var scheme
    
    
    var body: some View {
        Section {
            VStack(spacing: 0) {
                Image(_internalSystemName: symbolName)
                    .font(.system(size: 46))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.primary.gradient, .primary.opacity(0.25))
                    .shadow(color: .gray, radius: 35)
                    .bold()
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                
                Divider()
                
                
                HStack {
                    Text("Bookmarks")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .lineLimit(1, reservesSpace: true)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .bold()
                        .imageScale(.small)
                }
                .padding([.horizontal, .bottom], 13)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .if(scheme == .dark) {
                    $0.background(Material.regularMaterial)
                }
            }
        }
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    NavigationStack {
        Form {
            BookmarkCardView()
        }
    }
}
