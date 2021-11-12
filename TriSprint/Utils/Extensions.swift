//
//  Extensions.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

extension Color {
    static var accentButton: Color {
        Color("AccentButton")
    }
    static var mainButton: Color {
        Color("MainButton")
    }
    static var iconGreen: Color {
        Color("IconGreen")
    }
    static var mainBackground: Color {
        Color("MainBackground")
    }
    static var mainText: Color {
        Color("MainText")
    }
}

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case pList = "Plist"
    }
    
}
