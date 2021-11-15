//
//  TriSprintApp.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

@main
struct TriSprintApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
