//
//  BookDetailsPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/12/24.
//

import SwiftUI

struct BookDetailsPage: View {
    @Environment(\.dismiss) var dismiss
    
    var book: Book
    @State private var isBookCoverExpanded: Bool = false
    @State private var isShowingPublisherDetails: Bool = false
    @State private var isEditing: Bool = false
    var searchAction: (String) -> Void
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Image(book.bookCover ?? "No Cover")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .frame(width: isBookCoverExpanded ? (UIScreen.main.bounds.width - 40) : 200)
                    .animation(.easeInOut(duration: 0.3), value: isBookCoverExpanded)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            proxy.scrollTo("bookCover", anchor: .top)
                        }
                        self.isBookCoverExpanded.toggle()
                    }
                    .id("bookCover")
                
                VStack(alignment: .leading, spacing: 16) {
                    BookInfoView()
                    
                    BookDetailsView()
                    
                    TagsView {
                        ForEach(book.tags, id: \.self) { tag in
                            let viewWidth = tag.size(.preferredFont(forTextStyle: .body)).width + 24
                            
                            Text(tag)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.tertiary, in: Capsule())
                                .containerValue(\.viewWidth, viewWidth)
                                .onTapGesture {
                                    dismiss()
                                    searchAction("tag=\(tag)")
                                }
                        }
                    }
                    
                    // TODO: Add Publishing Info
                    ExpandableButtonViewTests(isExpanded: $isShowingPublisherDetails) {
                        BookPublishingDetails()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            isEditing.toggle()
                        } label: {
                            Text("Edit")
                                .themeStyle(.button)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 48)
                        }
                        .background(Color.accented, in: RoundedRectangle(cornerRadius: 8))
                        .padding(.top, 8)
                        
                        Spacer()
                    }

                }
                .padding(.horizontal)
                .padding(.vertical)
                .opacity(isBookCoverExpanded ? 0 : 1)
                .animation(.easeInOut(duration: 0.3), value: isBookCoverExpanded)
            }
            .scrollDisabled(isBookCoverExpanded)
            .background(Color.background)
            .toolbar {
                ToolbarItem {
                    Button {
                        book.isFavorite.toggle()
                    } label: {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(book.isFavorite ? Color.red : Color.text)
                            .accessibilityLabel("Favorite Book")
                    }
                }
            }
            .onChange(of: isShowingPublisherDetails) { _, newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        withAnimation(.easeIn) {
                            proxy.scrollTo("expandedView", anchor: .bottom)
                        }
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                BookInputPage(book: self.book)
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    private func BookInfoView() -> some View {
        VStack(spacing: 16) {
            TitledText(header: "Title", text: book.fullTitle)
            
            TitledText(header: "Author", text: book.authorName)
        }
    }
    
    private func BookDetailsView() -> some View {
        VStack(spacing: 16) {
            if let series = book.series, let number = book.seriesNumber {
                TitledButton(header: "Series", buttonText: series, bookNumber: number) {
                    dismiss()
                    searchAction("series=\(series)")
                }
            }
            
            TitledText(header: "Genre", text: book.genre)
            
            HStack {
                Spacer()
                
                TitledText(header: "# of Pages", text: book.numberOfPages != nil ? "\(book.numberOfPages!)" : "Unknown", alignment: .center)
                
                Rectangle()
                    .cornerRadius(1)
                    .frame(width: 2)
                    .padding(.horizontal)
                
                TitledText(header: "Date Added", text: book.dateAddedString, alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color.tertiary, in: RoundedRectangle(cornerRadius: 8))
        }
    }
    
    private func BookPublishingDetails() -> some View {
        VStack(spacing: 16) {
            if let publisher = book.publisher {
                TitledText(header: "Publisher", text: publisher)
                    .padding(.leading)
            }
            
            if let publishedDateString = book.publishedDateString {
                TitledText(header: "Published Date", text: publishedDateString)
                    .padding(.leading)
            }
            
            if let isbn = book.isbn {
                TitledText(header: "ISBN #", text: isbn)
                    .padding(.leading)
            }
            
            if book.publisher == nil && book.publishedDateString == nil && book.isbn == nil {
                HStack {
                    Image(systemName: "externaldrive.fill.badge.exclamationmark")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .scaledToFit()
                    
                    Text("It seems that you don't have any publisher details for this book.")
                        .themeStyle(.info)
                }
                .padding()
                .background(Color.tertiary, in: RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    let book = Book(
        title: "Lord of the Rings",
        subTitle: "Fellowship of the Rings",
        authorLastName: "Tolkein",
        publisher: "Houghton Miffin",
        publishedDate: .init(),
        numberOfPages: 423,
        genre: .fantasy(.high),
        series: "Lord of the Rings",
        seriesNumber: 1,
        isbn: "1234567890",
        bookCover: "Fellowship",
        tags: ["frodo", "tolkein", "middle-earth"])
    
    BookDetailsPage(book: book, searchAction: { _ in })
}
