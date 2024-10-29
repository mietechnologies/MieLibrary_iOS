//
//  BookInputPageViewModel.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/17/24.
//

import SwiftUI

@Observable
class BookInputViewModel {
    var book: Book?
    
    var title: String = ""
    var subtitle: String = ""
    var author: String = ""
    var publisher: String = ""
    var publishedDate: Date = .init()
    var numberOfPagesRaw: String = ""
    var genre: GenreType? = nil
    var series: String = ""
    var seriesNumberRaw: String = ""
    var isbn: String = ""
    var inputTag: String = ""
    
    var tags: [String] = []
    private var numberOfPages: Int? {
        Int(numberOfPagesRaw)
    }
    private var seriesNumber: Int? {
        Int(seriesNumberRaw)
    }
    
    init(book: Book? = nil) {
        self.book = book
        
        _title = book?.title ?? ""
        _subtitle = book?.subTitle ?? ""
        _author = book?.author ?? ""
        _publisher = book?.publisher ?? ""
        _publishedDate = book?.publishedDate ?? .init()
        _numberOfPagesRaw = book?.numberOfPages == nil ? "" : String(book!.numberOfPages!)
        _genre = GenreType(rawValue: book?.genre ?? "Adventure")
        _series = book?.series ?? ""
        _seriesNumberRaw = book?.seriesNumber == nil ? "" : String(book!.seriesNumber!)
        _isbn = book?.isbn ?? ""
        _tags = book?.tags ?? []
    }
    
    func addedBook() -> Book {
        return .init(
            title: title,
            subTitle: subtitle.isEmpty ? nil : subtitle,
            author: author,
            publisher: publisher.isEmpty ? nil : publisher,
            publishedDate: publishedDate,
            numberOfPages: numberOfPages == 0 ? nil : numberOfPages,
            genre: genre!,
            series: series.isEmpty ? nil : series,
            seriesNumber: seriesNumber == 0 ? nil : seriesNumber,
            isbn: isbn.isEmpty ? nil : isbn,
            bookCover: nil, // TODO: Implement logic for saving the bookCover in the cache and create a URL string
            tags: tags
        )
    }
    
    func updateBook() {
        if let book {
            book.title = title
            book.subTitle = subtitle.isEmpty ? nil : subtitle
            book.author = author
            book.publisher = publisher.isEmpty ? nil : publisher
            book.publishedDate = publishedDate
            book.numberOfPages = numberOfPages
            book.genre = genre?.rawValue ?? book.genre
            book.series = series.isEmpty ? nil : series
            book.seriesNumber = seriesNumber
            book.isbn = isbn.isEmpty ? nil : isbn
            book.tags = tags
        }
    }
    
    func constructBook() -> Book? {
        if let genre, !title.isEmpty, !author.isEmpty {
            let book = Book(title: title, author: author, genre: genre, tags: tags)
            return book
        } else {
            return nil
        }
    }
    
    func removeTag(_ tag: String) {
        tags.removeAll(where: { $0 == tag })
    }
    
    func addTag() {
        tags.append(inputTag.lowercased())
        _inputTag = ""
    }
}
