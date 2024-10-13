//
//  ViewExtension.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

extension View {
    func themeStyle(_ style: TextModifier.FontStyle,
                    lineSpacing: CGFloat = 1,
                    fontColor: Color = .text) -> some View {
        self.modifier(TextModifier(style: style, lineSpacing: lineSpacing, fontColor: fontColor))
    }
}
