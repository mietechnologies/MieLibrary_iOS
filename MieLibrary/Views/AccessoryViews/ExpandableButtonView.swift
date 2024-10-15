//
//  ExpandableButtonView.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/14/24.
//

import SwiftUI

struct ExpandableButtonViewTests<Content: View>: View {
    
    @Binding var isExpanded: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                withAnimation(.easeIn(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Publishing Details")
                        .themeStyle(.sectionHeader)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.accented)
                        .rotationEffect(isExpanded ? .degrees(180) : .degrees(0))
                }
            }
            
            if isExpanded {
                content
            }
        }
        .id("expandedView")
    }
}
