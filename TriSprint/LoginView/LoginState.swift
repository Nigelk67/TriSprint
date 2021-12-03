//
//  LoginState.swift
//  TriSprint
//
//  Created by Nigel Karan on 03.12.21.
//

import SwiftUI
import Combine

class LoginState: ObservableObject {
    @Published var loggedIn: Bool = false
}
