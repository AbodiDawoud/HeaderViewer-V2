//
//  SemanticColor.swift
//  HeaderViewer
    

import SwiftUI
import ClassDumpRuntime


struct SemanticColor {
    var standard: Color {
        get {
            value(ColorTheme.system.standard, forKey: CDSemanticType.standard.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.standard.key)
        }
    }
    
    
    var comment: Color {
        get {
            value(ColorTheme.system.comment, forKey: CDSemanticType.comment.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.comment.key)
        }
    }
    
    
    var keyword: Color {
        get {
            value(ColorTheme.system.keyword, forKey: CDSemanticType.keyword.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.keyword.key)
        }
    }
    
    
    var variable: Color {
        get {
            value(ColorTheme.system.variable, forKey: CDSemanticType.variable.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.variable.key)
        }
    }
    
    
    var number: Color {
        get {
            value(ColorTheme.system.number, forKey: CDSemanticType.numeric.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.numeric.key)
        }
    }
    
    
    var recordName: Color {
        get {
            value(ColorTheme.system.recordName, forKey: CDSemanticType.recordName.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.recordName.key)
        }
    }
    
    
    var `class`: Color {
        get {
            value(ColorTheme.system.class, forKey: CDSemanticType.class.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.class.key)
        }
    }
    
    
    var `protocol`: Color {
        get {
            value(ColorTheme.system.protocol, forKey: CDSemanticType.protocol.key)
        }
        
        set {
            setValue(newValue, forKey: CDSemanticType.protocol.key)
        }
    }
    
    
    // The "SemanticOptimizedRun" class is switching on a "default" value, we have to provide a color for it.
    var defaultValue: Color {
        get {
            value(ColorTheme.system.defaultValue, forKey: "default_color")
        }
        
        set {
            setValue(newValue, forKey: "default_color")
        }
    }
}

extension SemanticColor {
    private func value(_ defaultValue: Color, forKey key: String) -> Color {
        guard let hexValue = UserDefaults.standard.string(forKey: key)
        else { return defaultValue }
        
        return Color(hex: hexValue)
    }
    
    private func setValue(_ color: Color, forKey key: String) {
        UserDefaults.standard.set(color.toHex(), forKey: key)
    }
}


private extension CDSemanticType {
    /// The key to be stored in `UserDefaults`
    var key: String {
        switch self {
        case .standard: return "standard_color"
        case .comment: return "comment_color"
        case .keyword: return "keyword_color"
        case .variable: return "variable_color"
        case .numeric: return "numeric_color"
        case .recordName: return "record_name_color"
        case .class: return "class_color"
        case .protocol: return "protocol_color"
        
        default: return ""
        }
    }
}
