//
//  SettingsViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var isSaving: Bool = false
    //@Published var confirmed: Bool = false
    @Published var confirmDeletedPlans = false
    @Published var confirmDeletedActivities = false
    @Published var goToOnboarding: Bool = false
    let viewContext = PersistenceController.shared.container.viewContext
    
    func showDeletePlansSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            //self.confirmDeletedPlans = true
        }
    }
    func showDeleteActivitiesSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            self.confirmDeletedActivities = true
        }
    }
    
    func deleteActivities(swims: FetchedResults<Swim>, rides: FetchedResults<Ride>, runs: FetchedResults<Run>) {
        showDeleteActivitiesSpinner()
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
        showDeletePlansSpinner()
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
