//
//  TriSprintApp.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI
import Firebase

@main
struct TriSprintApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(loginViewModel)
        }
    }
}
