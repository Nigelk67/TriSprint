//
//  SettingsViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 04.12.21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

class SettingsViewModel: ObservableObject {
    
    @Published var isSaving: Bool = false
    //@Published var confirmed: Bool = false
    @Published var confirmDeletedPlans = false
    @Published var confirmDeletedActivities = false
    @Published var accountDeletedConfirmation = false
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
    
    func showDeleteAccountSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            self.accountDeletedConfirmation = true
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
    
    func logout() {
        if Auth.auth().currentUser?.uid == nil {
        }
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    func deleteUser() {
        showDeleteAccountSpinner()
        let user = Auth.auth().currentUser
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = Database.database().reference().child("users").child(uid)
        userRef.updateChildValues(["account":"DELETED"])
        user?.delete(completion: { (error) in
            if let err = error {
                print("Unable to delete user - error \(err)")
            } else {
                //CONFIRM ACCOUNT HAS BEEN DELETED. BACK TO ONBOARDING
            }
            
        })
    }
    

}
