//
//  GenreType.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/9/24.
//

import Foundation

enum GenreType: Codable {
    
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
}
