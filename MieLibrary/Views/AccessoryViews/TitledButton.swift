//
//  TitledButton.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

struct TitledButton: View {
    
    var header: String
    var buttonText: String
    var bookNumber: Int
    var alignment: HorizontalAlignment = .leading
    var action: () -> Void
    
    var body: some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            
            VStack(alignment: alignment) {
                Text(header)
                    .themeStyle(.subheader)
                
                HStack {
                    Text("Book \(bookNumber) of")
                        .themeStyle(.body)
                    
                    Button(action: action) {
                        Text(buttonText)
                            .themeStyle(.body, fontColor: .accented)
                            .fontWeight(.black)
                    }
                }
            }
            
            if alignment == .leading {
                Spacer()
            }
        }
    }
}
