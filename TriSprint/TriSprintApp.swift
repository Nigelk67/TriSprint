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
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.mainButton)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UITabBar.appearance().backgroundColor = UIColor(Color.mainBackground)
        UITabBar.appearance().barTintColor = UIColor(Color.mainBackground)
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
