//
//  TitledTextField.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/17/24.
//

import SwiftUI

struct TitledTextField: View {
    
    var title: String
    @Binding var text: String
    var onDone: (() -> Void)?
    
    init(_ title: String, text: Binding<String>, onDone: (() -> Void)? = nil) {
        self.title = title
        self._text = text
        self.onDone = onDone
    }
    
    var body: some View {
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
}
