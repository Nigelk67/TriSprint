//
//  CoreDataViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 27.11.21.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedPlans: [Plan] = []
    @Published var completedSwims: [Swim] = []
    @Published var completedRides: [Ride] = []
    @Published var completedRuns: [Run] = []
    
    init() {
        container = NSPersistentContainer(name: "TriSprint")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            } else {
                print("Successfully loaded Core data")
            }
        }
        fetchPlans()
        fetchRunsCompleted()
        fetchRidesCompleted()
        fetchSwimsCompleted()
    }
    
    func fetchPlans() {
        let request = NSFetchRequest<Plan>(entityName: "Plan")
        do {
            savedPlans = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error fetching plans", error)
        }
    }
    
    func fetchSwimsCompleted() {
        let request = NSFetchRequest<Swim>(entityName: "Swim")
        do {
            completedSwims = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching swims", error)
        }
    }
    
    func fetchRidesCompleted() {
        let request = NSFetchRequest<Ride>(entityName: "Ride")
        do {
            completedRides = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching rides", error)
        }
    }
    
    func fetchRunsCompleted() {
        let request = NSFetchRequest<Run>(entityName: "Run")
        do {
            completedRuns = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching runs", error)
        }
    }
    
    func deletePlan(plan: Plan) {
        container.viewContext.delete(plan)
        saveData()
    }
    
    func deleteActivity(indexSet: IndexSet) {
        print("delete activity")
    }
    
    func markPlanComplete(plan: Plan) {
        print("Plan completed - Day: \(plan.day ?? "")")
        plan.completed = 1
        saveData()
    }
    
    func savePlanToCoreData(trainingPlan: [Dictionary<String, Any>]) {
        
        for dict in trainingPlan {
            let training = TrainingPlan(dictionary: dict)
            
            let context = PersistenceController.shared.container.viewContext
            let plan = Plan(context: context)
            plan.completed = Int16(training.completed)
            plan.week = Int16(training.week)
            plan.session = training.session
            plan.phase = training.phase
            plan.day = training.day
            plan.swimDescription = training.swimDescription
            plan.swimRpe = training.swimRpe
            plan.swimTime = training.swimTime
            plan.rideRpe = training.rideRpe
            plan.rideTime = training.rideTime
            plan.rideDescription = training.rideDescription
            plan.runTime = training.runTime
            plan.runRpe = training.runRpe
            plan.runDescription = training.runDescription
            
            do {
                try context.save()
                
            } catch let err {
                print("Error saving plans to CoreData",err)
            }
        }
        fetchPlans()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPlans()
            fetchSwimsCompleted()
            fetchRunsCompleted()
            fetchRidesCompleted()
        } catch let error {
            print("Error saving to CoreData", error)
        }
    }
    
}

