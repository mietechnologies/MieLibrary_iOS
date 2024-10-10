//
//  SampleData.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/9/24.
//

import Foundation
import SwiftData

@MainActor
let sampleData: ModelContainer = {
    do {
        let container = try ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        ExampleData.books.enumerated().forEach { index, book in
            container.mainContext.insert(book)
        }
        
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()

struct ExampleData {
    static let books: [Book] = {
        return [
            Book(title: "Lord of the Rings", subTitle: "The Fellowship of the Rings", author: "J.R.R. Tolkien", genre: .fantasy(.high), bookCover: "Fellowship", tags: ["adventure", "frodo"]),
            Book(title: "Lord of the Rings", subTitle: "The Two Towers", author: "J.R.R. Tolkien", genre: .fantasy(.high), bookCover: "Towers", tags: ["adventure", "frodo"]),
            Book(title: "Lord of the Rings", subTitle: "The Return of the King", author: "J.R.R. Tolkien", genre: .fantasy(.high), bookCover: "King", tags: ["adventure", "frodo"]),
            Book(title: "The Hobbit", author: "J.R.R. Tolkien", genre: .fantasy(.high), bookCover: "Hobbit", tags: ["adventure", "bilbo"]),
            Book(title: "The Historian", author: "Elizabeth Kostava", genre: .mystery(.psychologicalThriller), bookCover: "Historian", tags: ["dracula", "vampires", "history", "europe"]),
            Book(title: "Dracula", author: "Bram Stoker", genre: .horror, bookCover: "Dracula", tags: ["dracula", "vampires", "history", "europe", "classic", "monsters"]),
            Book(title: "Frankenstein", author: "Mary Shelley", genre: .horror, bookCover: "Frankenstein", tags: ["frankenstein", "classic", "monsters"]),
            Book(title: "World War Z", author: "Max Brooks", genre: .literaryFiction(.postApocalytic), tags: ["zombies", "monsters"]),
        ]
    }()
}
