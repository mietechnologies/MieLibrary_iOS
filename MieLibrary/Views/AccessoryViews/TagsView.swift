//
//  TagsView.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/13/24.
//

import SwiftUI

public struct TagsView<Content: View>: View {
    @ViewBuilder var content: Content
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Tags")
                .themeStyle(.subheader)
            
            Group(subviews: content) { collection in
                let chunkedCollection = collection.chunkedByWidth(UIScreen.main.bounds.width - 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(chunkedCollection.indices, id: \.self) { index in
                        HStack(spacing: 10) {
                            ForEach(chunkedCollection[index]) { subview in
                                subview
                            }
                        }
                    }
                }
            }
        }
    }
}
