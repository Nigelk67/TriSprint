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
    
    //For background identfication:
    @StateObject var sessionVm = SessionViewModel()
    @Environment(\.scenePhase) var scene
    
    init() {
        FirebaseApp.configure()
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.mainButton)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentButton.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UITabBar.appearance().backgroundColor = UIColor(Color.mainBackground)
        UITabBar.appearance().barTintColor = UIColor(Color.mainBackground)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.accentButton)
    }
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(loginViewModel)
                .environmentObject(sessionVm)
        }
        .onChange(of: scene) { newScene in
            if newScene == .background {
                sessionVm.timeAtBackground = Date()
            }
            if newScene == .active {
                let diffInSecs = Date().timeIntervalSince(sessionVm.timeAtBackground)
                let currentTime = sessionVm.secs + Double(diffInSecs)
                if currentTime >= 0 {
                    withAnimation(.default) {
                        sessionVm.secs = currentTime
                        sessionVm.updateDisplay()
                    }
                }
            }
        }
    }
}
