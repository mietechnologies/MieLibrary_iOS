//
//  LibraryPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

struct LibraryPage: View {
    
    var books: [Book]
    var addBook: ((Book) -> Void)
    
    @State private var searchText: String = ""
    
    private var filteredBooks: [Book] {
        return searchText.isEmpty ? books : books.filter({ $0.search(with: searchText) })
    }
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .bottom), count: 5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 10) {
                        ForEach(filteredBooks) { book in
                            NavigationLink(value: book) {
                                Image(book.bookCover ?? "No Cover")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .padding(8)
                
                Text("\(filteredBooks.count) Books")
                    .font(.headline)
                    .foregroundStyle(Color.tertiary)
                    .padding(.bottom, 8)
            }
            .navigationTitle("Library")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Library")
            .toolbar {
                ToolbarItem {
                    Button {
                        addBook(
                            Book(title: "Test Book", subTitle: "\(Int.random(in: 0..<100))", author: "Test Author", genre: .adventure, tags: [])
                        )
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.text)
                            .accessibilityLabel("Add Item")
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                Text(book.title) // TODO: Update to the BookDetailPage
            }
        }
        .tint(.text)
    }
}
