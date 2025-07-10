//
//  View+.swift
//  HeaderViewer
    

import SwiftUI


extension View {
    func `if`(_ condition: Bool, modifier: @escaping (Self) -> some View) -> some View {
        if condition {
            AnyView(modifier(self))
        } else {
            AnyView(self)
        }
    }
    
    func backport(@ViewBuilder _ modifier: @escaping (Self) -> some View) -> some View {
        AnyView(modifier(self))
    }
}
