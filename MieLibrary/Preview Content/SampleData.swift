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
            Book(title: "Lord of the Rings", subTitle: "The Fellowship of the Rings", author: "J.R.R. Tolkien", genre: .fantasy(.high), series: "Lord of the Rings", seriesNumber: 1, bookCover: "Fellowship", tags: ["adventure", "frodo"]),
            Book(title: "Lord of the Rings", subTitle: "The Two Towers", author: "J.R.R. Tolkien", genre: .fantasy(.high), series: "Lord of the Rings", seriesNumber: 2, bookCover: "Towers", tags: ["adventure", "frodo"]),
            Book(title: "Lord of the Rings", subTitle: "The Return of the King", author: "J.R.R. Tolkien", genre: .fantasy(.high), series: "Lord of the Rings", seriesNumber: 3, bookCover: "King", tags: ["adventure", "frodo"]),
            Book(title: "The Hobbit", author: "J.R.R. Tolkien", genre: .fantasy(.high), bookCover: "Hobbit", tags: ["adventure", "bilbo"]),
            Book(title: "The Historian", author: "Elizabeth Kostava", genre: .mystery(.psychologicalThriller), bookCover: "Historian", tags: ["dracula", "vampires", "history", "europe"]),
            Book(title: "Dracula", author: "Bram Stoker", genre: .horror, bookCover: "Dracula", tags: ["dracula", "vampires", "history", "europe", "classic", "monsters"]),
            Book(title: "Frankenstein", author: "Mary Shelley", genre: .horror, bookCover: "Frankenstein", tags: ["frankenstein", "classic", "monsters"]),
            Book(title: "World War Z", author: "Max Brooks", genre: .literaryFiction(.postApocalytic), bookCover: "World War", tags: ["zombies", "monsters"]),
            Book(title: "1984", author: "George Orwell", genre: .literaryFiction(.dystopian), bookCover: "1984", tags: ["classic", "politics", "socialism"]),
            Book(title: "Animal Farm", author: "George Orwell", genre: .literaryFiction(.dystopian), bookCover: "Farm", tags: ["classic", "politics", "warning"]),
            Book(title: "Brave New World", author: "Aldous Huxley", genre: .literaryFiction(.dystopian), bookCover: "Brave", tags: ["classic", "politics", "warning"]),
            Book(title: "The Girl with all the Gifts", author: "M.R. Carey", genre: .literaryFiction(.postApocalytic), bookCover: "Gifts", tags: ["zombies"]),
            Book(title: "The Boy on the Bridge", author: "M.R. Carey", genre: .literaryFiction(.postApocalytic), bookCover: "Bridge", tags: ["zombies"]),
            Book(title: "The Passage", author: "Justin Cronin", genre: .literaryFiction(.postApocalytic), bookCover: "Passage", tags: ["zombies", "vampires"]),
            Book(title: "The Zombie Survival Guide", subTitle: "Complete Protection From The Living Dead", author: "Max Brooks", genre: .literaryFiction(.urbanFantasy), tags: ["zombies", "survival"])
        ]
    }()
}
