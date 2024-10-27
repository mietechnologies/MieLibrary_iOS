//
//  SettingsCache.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/27/24.
//

import Foundation

class SettingsCache {
    private let userDefaults = UserDefaults(suiteName: "settings")
    
    func set<T: Codable>(_ data: T, for key: SettingsKey) throws {
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(data) else {
            throw SettingsError.invalidData
        }
        userDefaults?.set(encodedData, forKey: key.rawValue)
        print("Saved \(key.rawValue)")
    }
    
    func get<T: Codable>(_ type: T.Type, for key: SettingsKey) throws -> T {
        guard let storedData = userDefaults?.data(forKey: key.rawValue) else {
            throw SettingsError.dataNotFound
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(type, from: storedData) else {
            throw SettingsError.dataMismatch
        }
        return decodedData
    }
}

extension SettingsCache {
    enum SettingsError: Error {
        case invalidData
        case dataNotFound
        case dataMismatch
    }
}

extension SettingsCache {
    // MARK: This will need updated whenever a new setting is being stored
    enum SettingsKey: String {
        case sortingMethod
        case sortingOrder
    }
}
