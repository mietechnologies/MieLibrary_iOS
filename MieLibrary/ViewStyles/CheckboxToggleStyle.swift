//
//  CheckboxToggleStyle.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/26/24.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(Color.accented)
                    .background(.clear)
                    .frame(width: 25, height: 25)
                
                RoundedRectangle(cornerRadius: 2)
                    .stroke(lineWidth: 0)
                    .background(RoundedRectangle(cornerRadius: 2).fill(configuration.isOn ? Color.highlight : Color.clear))
                    .frame(width: configuration.isOn ? 19 : 0, height: configuration.isOn ? 19 : 0)
            }
        }
    }
                
}

// MARK: Ease of use Accessor

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkboxToggle: CheckboxToggleStyle { .init() }
}
