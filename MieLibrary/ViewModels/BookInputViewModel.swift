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
    var authorFirstName: String = ""
    var authorLastName: String = ""
    var publisher: String = ""
    var publishedDate: Date? = nil
    var numberOfPages: String = ""
    var genre: GenreType? = nil
    var series: String = ""
    var seriesNumber: String = ""
    var isbn: String = ""
    var inputTag: String = ""
    var showMissingFields: Bool = false
    
    var tags: [String] = []
    
    init(book: Book? = nil) {
        self.book = book
        
        _title = book?.title ?? ""
        _subtitle = book?.subTitle ?? ""
        _authorFirstName = book?.authorFirstName ?? ""
        _authorLastName = book?.authorLastName ?? ""
        _publisher = book?.publisher ?? ""
        _publishedDate = book?.publishedDate ?? .init()
        _numberOfPages = book?.numberOfPages == nil ? "" : String(book!.numberOfPages!)
        if let genre = book?.genre {
            _genre = GenreType(rawValue: genre)
        }
        _series = book?.series ?? ""
        _seriesNumber = book?.seriesNumber == nil ? "" : String(book!.seriesNumber!)
        _isbn = book?.isbn ?? ""
        _tags = book?.tags ?? []
    }
    
    func constructBook() -> Book? {
        if let genre, !title.isEmpty, !authorLastName.isEmpty {
            return .init(
                title: title,
                subTitle: subtitle,
                authorFirstName: authorFirstName,
                authorLastName: authorLastName,
                publisher: publisher,
                publishedDate: publishedDate,
                numberOfPages: Int(numberOfPages),
                genre: genre,
                series: series,
                seriesNumber: Int(seriesNumber),
                isbn: isbn,
                bookCover: nil, // TODO: Implement logic for saving the bookCover in the cache and create a URL string
                tags: tags
            )
        }
        
        showMissingFields = true
        return nil
    }
    
    func updateBook() {
        if let book, let genre, !title.isEmpty, !authorLastName.isEmpty {
            book.title = title
            book.subTitle = subtitle.isEmpty ? nil : subtitle
            book.authorFirstName = authorFirstName.isEmpty ? nil : authorFirstName
            book.authorLastName = authorLastName
            book.publisher = publisher.isEmpty ? nil : publisher
            book.publishedDate = publishedDate
            book.numberOfPages = Int(numberOfPages)
            book.genre = genre.rawValue
            book.series = series.isEmpty ? nil : series
            book.seriesNumber = Int(seriesNumber)
            book.isbn = isbn.isEmpty ? nil : isbn
            book.tags = tags
        }
        
        showMissingFields = true
    }
    
    func removeTag(_ tag: String) {
        tags.removeAll(where: { $0 == tag })
    }
    
    func addTag() {
        tags.append(inputTag.lowercased())
        _inputTag = ""
    }
}
