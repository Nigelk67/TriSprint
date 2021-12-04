//
//  SettingsViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var isSaving: Bool = false
    @Published var confirmed: Bool = false
    @Published var goToOnboarding: Bool = false
    let viewContext = PersistenceController.shared.container.viewContext
    
    func showSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            self.confirmed = true
        }
    }
    
    func deleteActivities(swims: FetchedResults<Swim>, rides: FetchedResults<Ride>, runs: FetchedResults<Run>) {
        showSpinner()
        swims.forEach { swim in
            self.viewContext.delete(swim)
        }
        rides.forEach { ride in
            self.viewContext.delete(ride)
        }
        runs.forEach { run in
            self.viewContext.delete(run)
        }
        do {
            try self.viewContext.save()
        } catch {
            print("Failed to delete activities", error)
        }
    }
    
    func deletePlans(plans: FetchedResults<Plan>) {
        showSpinner()
        plans.forEach { plan in
            self.viewContext.delete(plan)
        }
        do {
            try self.viewContext.save()
        } catch {
            print("Failed to delete all plans", error)
        }
        self.goToOnboarding = true
        
    }
    
}
