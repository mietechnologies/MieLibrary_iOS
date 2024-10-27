//
//  SortingCategories.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/19/24.
//

import Foundation

enum SortingCategory: String, Codable, CaseIterable, Identifiable {
    
    case title = "Title"
    case author = "Author"
    case dateAdded = "Date Added"
    case publisher = "Publisher"
    case genre = "Genre"
    
    var id: String { self.rawValue }
    
    func sortDescriptors(_ order: SortOrder = .forward) -> [SortDescriptor<Book>] {
        switch self {
        case .title:
            return [
                SortDescriptor(\Book.title, order: order),
                SortDescriptor(\Book.subTitle, order: .forward)
            ]
        case .author: // TODO: Update for when author name is split
            return [
                SortDescriptor(\Book.author, order: order),
                SortDescriptor(\Book.title, order: .forward),
                SortDescriptor(\Book.subTitle, order: .forward)
            ]
        case .dateAdded:
            return [
                SortDescriptor(\Book.dateAdded, order: order)
            ]
        case .publisher:
            return [
                SortDescriptor(\Book.publisher, order: order),
                SortDescriptor(\Book.title, order: .forward),
                SortDescriptor(\Book.subTitle, order: .forward)
            ]
        case .genre:
            return [
                SortDescriptor(\Book.genre, order: order),
                SortDescriptor(\Book.title, order: .forward),
                SortDescriptor(\Book.subTitle, order: .forward)
            ]
        }
    }
}
