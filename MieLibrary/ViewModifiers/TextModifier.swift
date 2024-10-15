//
//  TextModifier.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let style: FontStyle
    let lineSpacing: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(style.font(size: fontSize))
            .lineSpacing(lineSpacing)
            .foregroundStyle(fontColor)
            .tracking(style == .body ? 0 : 1)
    }
    
    private var baseFontSize: CGFloat {
        switch style {
        case .header:           return 30
        case .subheader:        return 18
        case .body:             return 24
        case .info:             return 20
        case .sectionHeader:    return 24
        case .button:           return 20
        }
    }
    
    private var fontSize: CGFloat {
        switch dynamicTypeSize {
        case .xSmall:
            return baseFontSize * 0.7
        case .small:
            return baseFontSize * 0.8
        case .medium:
            return baseFontSize * 0.9
        case .large:
            return baseFontSize
        case .xLarge:
            return baseFontSize * 1.2
        case .xxLarge:
            return baseFontSize * 1.4
        case .xxxLarge:
            return baseFontSize * 1.6
        case .accessibility1:
            return baseFontSize * 1.8
        default:
            return baseFontSize * 2
        }
    }
}

extension TextModifier {
    enum FontStyle {
        case header
        case subheader
        case body
        case info
        case sectionHeader
        case button
        
        func font(size: CGFloat) -> Font {
            switch self {
            case .header:           return .system(size: size, weight: .black, design: .default)
            case .subheader:        return .system(size: size, weight: .heavy, design: .default)
            case .body:             return .system(size: size, weight: .regular, design: .default)
            case .info:             return .system(size: size, weight: .light, design: .default)
            case .sectionHeader:    return .system(size: size, weight: .heavy, design: .default)
            case .button:           return .system(size: size, weight: .semibold, design: .default)
            }
        }
    }
}

#Preview("Header Theme", traits: .sizeThatFitsLayout) {
    Text("Header")
        .themeStyle(.header)
}

#Preview("Subheader Theme", traits: .sizeThatFitsLayout) {
    Text("Subheader")
        .themeStyle(.subheader)
}

#Preview("Body Theme", traits: .sizeThatFitsLayout) {
    Text("Body")
        .themeStyle(.body)
}
