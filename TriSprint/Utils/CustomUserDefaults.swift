//
//  CustomUserDefaults.swift
//  TriSprint
//
//  Created by Nigel Karan on 26.11.21.
//

import Foundation

class CustomUserDefaults {
    enum DefaultKeys: String, CaseIterable {
        case pList
        case first
        case fitnessLevel
        case trainingDays
        case measure
    }
    static let shared = CustomUserDefaults()
    private let defaults = UserDefaults.standard
    
    init() {}
        func set(_ value: Any?, key: DefaultKeys) {
            defaults.setValue(value, forKey: key.rawValue)
        }
        func get(key: DefaultKeys) -> Any? {
            return defaults.value(forKey: key.rawValue)
        }
    
}
