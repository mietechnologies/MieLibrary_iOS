//
//  AppSettings.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/27/24.
//

import SwiftUI

@Observable
class AppSettings {
    private let settings = SettingsCache()
    
    var sortMethod: SortingCategory = .title {
        didSet {
            do {
                try settings.set(sortMethod, for: .sortingMethod)
            } catch let error {
                print(error)
            }
        }
    }
    var sortOrder: SortOrder = .forward {
        didSet {
            do {
                try settings.set(sortOrder, for: .sortingOrder)
            } catch let error {
                print(error)
            }
        }
    }
    
    init() {
        do {
            _sortMethod = try settings.get(SortingCategory.self, for: .sortingMethod)
            _sortOrder = try settings.get(SortOrder.self, for: .sortingOrder)
        } catch let error {
            if let settingsError = error as? SettingsCache.SettingsError {
                switch settingsError {
                case .dataNotFound:
                    _sortMethod = .title
                    _sortOrder = .forward
                default:
                    break
                }
            }
        }
    }
}
