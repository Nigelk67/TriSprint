//
//  TriSprintApp.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI
import CoreData

@main
struct TriSprintApp: App {
    let persistenceController = PersistenceController.shared
    //let container = NSPersistentContainer(name: "TriSprint")

    var body: some Scene {
        WindowGroup {
            MainView()
                //.environment(\.managedObjectContext, container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
