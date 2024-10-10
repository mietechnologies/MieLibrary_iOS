//
//  Book.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/9/24.
//

import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var subTitle: String
    var author: String
    var publisher: String?
    var publishedDate: Date?
    var numberOfPages: Int?
    var genre: GenreType
    var series: String?
    var seriesNumber: Int?
    @Attribute(.unique) var isbn: String?
    var bookCover: String? // TODO: Update to URL
    var tags: [String]
    var dateAdded: Date
    var isFavorite: Bool
    
    init(
        title: String,
        subTitle: String,
        author: String,
        publisher: String? = nil,
        publishedDate: Date? = nil,
        numberOfPages: Int? = nil,
        genre: GenreType,
        series: String? = nil,
        seriesNumber: Int? = nil,
        isbn: String? = nil,
        bookCover: String? = nil,
        tags: [String],
        dateAdded: Date = Date(),
        isFavorite: Bool
    ) {
        self.title = title
        self.subTitle = subTitle
        self.author = author
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.numberOfPages = numberOfPages
        self.genre = genre
        self.series = series
        self.seriesNumber = seriesNumber
        self.isbn = isbn
        self.bookCover = bookCover
        self.tags = tags
        self.dateAdded = dateAdded
        self.isFavorite = isFavorite
    }
}
