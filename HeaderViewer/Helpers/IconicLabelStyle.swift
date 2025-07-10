//
//  IconicLabelStyle.swift
//  HeaderViewer
    

import SwiftUI


struct IconicLabelStyle: LabelStyle {
    private let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .symbolRenderingMode(.hierarchical)
                .background(color.gradient, in: .rect(cornerRadius: 10.5))
            
            configuration.title
        }
    }
}
