//
//  LibraryPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI
import SwiftData

struct LibraryPage: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var books: [Book]
    var addBook: ((Book) -> Void)
    
    @State private var showSortPage: Bool = false
    @State private var addBookManually: Bool = false
    @State private var searchText: String = ""
    @Binding var sorting: SortingCategory
    @Binding var sortDirection: SortOrder
    
    private var filteredBooks: [Book] {
        return searchText.isEmpty ? books : books.search(for: searchText)
    }
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .bottom), count: 5)
    
    init(sorting: Binding<SortingCategory>, order: Binding<SortOrder>, addBook: @escaping (Book) -> Void) {
        self.addBook = addBook
        _sorting = sorting
        _sortDirection = order
        _books = Query(sort: sorting.wrappedValue.sortDescriptors(sortDirection), animation: .default)
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
                        showSortPage.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundStyle(Color.text)
                            .accessibilityLabel("Sort Library")
                    }
                }
                
                ToolbarItem {
                    Menu("Add Book", systemImage: "plus") {
                        Button {
                            addBookManually.toggle()
                        } label: {
                            Label("Add Manually", systemImage: "text.book.closed.fill")
                        }
                        
                        Button {
                            print("Scan Barcode")
                        } label: {
                            Label("Scan Barcode", systemImage: "barcode.viewfinder")
                        }
                    }
                    .foregroundStyle(Color.text)
                }
                
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailsPage(book: book) { searchTerm in
                    self.searchText = searchTerm
                }
            }
            .sheet(isPresented: $showSortPage) {
                SortPage(selection: $sorting, order: $sortDirection)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $addBookManually) {
                BookInputPage { book in
                    modelContext.insert(book)
                }
            }
        }
        .tint(.text)
    }
}
