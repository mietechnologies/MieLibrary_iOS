//
//  Book.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/9/24.
//

import Foundation
import SwiftData

@Model
final class Book: Identifiable {
    var id: String {
        guard let subTitle = subTitle else { return title }
        return "\(title): \(subTitle)"
    }
    var title: String
    var subTitle: String?
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
    
    var fullTitle: String {
        guard let subTitle else { return title }
        return "\(title): \(subTitle)"
    }
    
    var publishedDateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let publishedDate else { return nil }
        
        return dateFormatter.string(from: publishedDate)
    }
    
    var dateAddedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: dateAdded)
    }
    
    init(
        title: String,
        subTitle: String? = nil,
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
        isFavorite: Bool = false
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
    
    public func search(with text: String) -> Bool {
        if title.lowercased().contains(text.lowercased()) {
            return true
        }
        
        if subTitle?.lowercased().contains(text.lowercased()) ?? false {
            return true
        }
        
        if author.lowercased().contains(text.lowercased()) {
            return true
        }
        
        if series?.lowercased().contains(text.lowercased()) ?? false {
            return true
        }
        
        return false
    }
}

extension Array where Element == Book {
    func search(for text: String) -> [Book] {
        let splitText = text.split(separator: "=")
        
        if splitText.count > 1 {
            let searchText = splitText[0].lowercased()
            let searchPhrase = splitText[1].lowercased()
            
            if searchText == "tag" || searchText == "tags" {
                return self.filter({ !$0.tags.filter({ $0.contains(searchPhrase) }).isEmpty })
            }
            
            if searchText == "author" {
                return self.filter({ $0.author.lowercased().contains(searchPhrase) })
            }
            
            if searchText == "publisher" {
                return self.filter({
                    guard let publisher = $0.publisher else { return false }
                    return publisher.lowercased().contains(searchPhrase)
                })
            }
            
            if searchText == "series" {
                return self.filter({
                    guard let series = $0.series else { return false }
                    return series.lowercased().contains(searchPhrase)
                })
            }
            
            if searchText == "genre" {
                return self.filter({ $0.genre.rawValue.contains(searchPhrase) })
            }
            
            return []
        } else {
            return self.filter({ $0.search(with: text) })
        }
    }
}
