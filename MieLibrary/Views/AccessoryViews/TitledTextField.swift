//
//  TitledTextField.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/17/24.
//

import SwiftUI

struct TitledTextField: View {
    
    var title: String
    var type: TitleType
    @Binding var text: String
    var onDone: (() -> Void)?
    
    init(_ title: String, text: Binding<String>, titleType: TitleType = .vertical, onDone: (() -> Void)? = nil) {
        self.title = title
        self.type = titleType
        self._text = text
        self.onDone = onDone
    }
    
    var body: some View {
        if type == .vertical {
            VerticalLook()
        } else {
            HorizontalLook()
        }
    }
    
    private func VerticalLook() -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .themeStyle(.subheader)
            
            TextField("", text: $text)
                .themeStyle(.body)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if let onDone {
                        onDone()
                    }
                }
        }
    }
    
    private func HorizontalLook() -> some View {
        HStack(alignment: .center) {
            Text(title)
                .themeStyle(.subheader)
            
            Spacer()
            
            TextField("", text: $text)
                .themeStyle(.body)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if let onDone {
                        onDone()
                    }
                }
                .frame(width: 100)
        }
    }
}

extension TitledTextField {
    enum TitleType {
        case horizontal
        case vertical
    }
}
