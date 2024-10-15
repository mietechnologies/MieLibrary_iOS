//
//  TitledText.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

struct TitledText: View {
    
    var header: String
    var text: String
    var alignment: HorizontalAlignment = .leading

    var body: some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            
            VStack(alignment: alignment) {
                
                Text(header)
                    .themeStyle(.subheader)
                
                Text(text)
                    .themeStyle(.body)
                
            }
            
            if alignment == .leading {
                Spacer()
            }
        }
    }
}
