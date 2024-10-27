//
//  GenreType.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/9/24.
//

import Foundation

enum GenreType: Codable, Hashable, CaseIterable {
    
    typealias RawValue = String
    
    case adventure
    case fantasy(FantasySubtype)
    case sciFi
    case historicalFiction
    case horror
    case mystery(SuspenseSubtype)
    case thriller(SuspenseSubtype)
    case romance
    case literaryFiction(LiteraryFictionSubtype)
    case youngAdult
    case biography
    case memoir
    case selfHelp
    case history
    case travel
    case trueCrime
    case philosophy
    case science
    case cooking
    case essayCollection
    case journalism(JournalismSubtype)
    
    enum FantasySubtype: String, Codable {
        case high = "High"
        case low = "Low"
        case dark = "Dark"
        case swordAndSorcery = "Sword and Sorcery"
    }
    
    enum JournalismSubtype: String, Codable {
        case newspaper = "Newspaper"
        case magazine = "Magazine"
    }
    
    enum LiteraryFictionSubtype: String, Codable {
        case dystopian = "Dystopian"
        case utopian = "Utopian"
        case postApocalytic = "Post-Apocalyptic"
        case steamPunk = "Steam Punk"
        case urbanFantasy = "Urban Fantasy"
        case paranormal = "Paranormal"
        case artificialIntelligence = "Artificial Intelligence"
    }
    
    enum SuspenseSubtype: String, Codable {
        case detective = "Detective"
        case psychologicalThriller = "Psychological Thriller"
        case crime = "Crime"
        case legal = "Legal"
        case spy = "Spy"
    }
    
    static var allCases: [GenreType] {
        return [
            .adventure,
            .fantasy(.high),
            .fantasy(.low),
            .fantasy(.dark),
            .fantasy(.swordAndSorcery),
            .sciFi,
            .historicalFiction,
            .horror,
            .mystery(.detective),
            .mystery(.psychologicalThriller),
            .mystery(.crime),
            .mystery(.legal),
            .mystery(.spy),
            .thriller(.detective),
            .thriller(.psychologicalThriller),
            .thriller(.crime),
            .thriller(.legal),
            .thriller(.spy),
            .romance,
            .literaryFiction(.dystopian),
            .literaryFiction(.utopian),
            .literaryFiction(.postApocalytic),
            .literaryFiction(.steamPunk),
            .literaryFiction(.urbanFantasy),
            .literaryFiction(.paranormal),
            .literaryFiction(.artificialIntelligence),
            .youngAdult,
            .biography,
            .memoir,
            .selfHelp,
            .history,
            .travel,
            .trueCrime,
            .philosophy,
            .science,
            .cooking,
            .essayCollection,
            .journalism(.magazine),
            .journalism(.newspaper)
        ]
    }
    
    var rawValue: String {
        switch self {
        case .adventure: return "Adventure"
        case let .fantasy(subtype): return "Fantasy/\(subtype.rawValue)"
        case .sciFi: return "Science Fiction"
        case .historicalFiction: return "Historical Fiction"
        case .horror: return "Horror"
        case let .mystery(subtype): return "Mystery/\(subtype.rawValue)"
        case let .thriller(subtype): return "Thriller/\(subtype.rawValue)"
        case .romance: return "Romance"
        case let .literaryFiction(subtype): return "Literary Fiction/\(subtype.rawValue)"
        case .youngAdult: return "Young Adult"
        case .biography: return "Biography"
        case .memoir: return "Memoir"
        case .selfHelp: return "Self-Help"
        case .history: return "History"
        case .travel: return "Travel"
        case .trueCrime: return "True Crime"
        case .philosophy: return "Philosophy"
        case .science: return "Science"
        case .cooking: return "Cooking"
        case .essayCollection: return "Essay Collection"
        case let .journalism(subtype): return "Journalism/\(subtype.rawValue)"
        }
    }

    init?(rawValue: String) {
        let splitValue = rawValue.split(separator: "/")
        if splitValue.count == 1 {
            switch rawValue {
            case "Adventure": self = .adventure
            case "Science Fiction": self = .sciFi
            case "Historical Fiction": self = .historicalFiction
            case "Horror": self = .horror
            case "Romance": self = .romance
            case "Young Adult": self = .youngAdult
            case "Biography": self = .biography
            case "Memoir": self = .memoir
            case "Self-Help": self = .selfHelp
            case "History": self = .history
            case "Travel": self = .travel
            case "True Crime": self = .trueCrime
            case "Philosophy": self = .philosophy
            case "Science": self = .science
            case "Cooking": self = .cooking
            case "Essay Collection": self = .essayCollection
            default: return nil
            }
        } else {
            if let fantasySubtype = FantasySubtype(rawValue: String(splitValue[1])) {
                self = .fantasy(fantasySubtype)
            } else if let journalismSubtype = JournalismSubtype(rawValue: String(splitValue[1])) {
                self = .journalism(journalismSubtype)
            } else if let literarySubtype = LiteraryFictionSubtype(rawValue: String(splitValue[1])) {
                self = .literaryFiction(literarySubtype)
            } else if let suspenseSubtype = SuspenseSubtype(rawValue: String(splitValue[1])) {
                switch String(splitValue[0]) {
                case "Mystery": self = .mystery(suspenseSubtype)
                case "Thriller": self = .thriller(suspenseSubtype)
                default: return nil
                }
            } else {
                return nil
            }
        }
    }
}

extension GenreType: Comparable {
    static func < (lhs: GenreType, rhs: GenreType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
