//
//  LibraryPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI
import SwiftData

struct LibraryPage: View {
    
    @Query private var books: [Book]
    var addBook: ((Book) -> Void)
    
    @State private var searchText: String = ""
    @Binding var sortOrder: [SortDescriptor<Book>]
    
    private var filteredBooks: [Book] {
        return searchText.isEmpty ? books : books.search(for: searchText)
    }
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .bottom), count: 5)
    
    init(sortOrder: Binding<[SortDescriptor<Book>]>, addBook: @escaping (Book) -> Void) {
        self.addBook = addBook
        _sortOrder = sortOrder
        _books = Query(sort: sortOrder.wrappedValue, animation: .default)
    }
    
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
                        withAnimation {
                            addBook(
                                Book(
                                    title: "Lord of the Rings",
                                    subTitle: "Fellowship of the Rings",
                                    author: "J.R.R Tolkein",
                                    publisher: "Houghton Miffin",
                                    publishedDate: .init(),
                                    numberOfPages: 423,
                                    genre: .fantasy(.high),
                                    series: "Lord of the Rings",
                                    seriesNumber: 1,
                                    isbn: "1234567890",
                                    bookCover: "Fellowship",
                                    tags: ["frodo", "tolkein", "middle-earth"])
    //                            ExampleData.books.randomElement()!
                            )
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.text)
                            .accessibilityLabel("Add Item")
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailsPage(book: book) { searchTerm in
                    self.searchText = searchTerm
                }
            }
        }
        .tint(.text)
    }
}
