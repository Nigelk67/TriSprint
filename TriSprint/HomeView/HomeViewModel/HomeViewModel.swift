//
//  HomeViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var measure: String = UserDefaults.standard.string(forKey: UserDefaults.Keys.measure.rawValue) ?? ""
    @Published var totalNumberofPlans = ""
    @Published var plansCompleted = ""
    @Published var swimPlansTotal = ""
    @Published var swimPlansCompleted = ""
    @Published var ridePlansTotal = ""
    @Published var ridePlansCompleted = ""
    @Published var runPlansTotal = ""
    @Published var runPlansCompleted = ""
    @Published var swimSpeedLatest = ""
    @Published var swimSpeedFastest = ""
    @Published var rideSpeedLatest = ""
    @Published var rideSpeedFastest = ""
    @Published var runSpeedLatest = ""
    @Published var runSpeedFastest = ""
    @Published var swimPaceLatest = ""
    @Published var swimPaceFastest = ""
    @Published var ridePaceLatest = ""
    @Published var ridePaceFastest = ""
    @Published var runPaceLatest = ""
    @Published var runPaceFastest = ""
    
    func calculateTotalNumberOfPlans(plans: FetchedResults<Plan>) -> Double {
        let totalPlans = plans.count
        let plansDble = Double(totalPlans)
        return plansDble
    }
    
    func calculateTotalNumberOfSwims(swims: FetchedResults<Swim>) -> Double {
        let totalSwims = swims.count
        let swimsDble = Double(totalSwims)
        return swimsDble
    }
    
    func calculateTotalNumberOfRides(rides: FetchedResults<Ride>) -> Double {
        let totalRides = rides.count
        let ridesDbl = Double(totalRides)
        return ridesDbl
    }
    
    func calculateTotalNumberOfRuns(runs: FetchedResults<Run>) -> Double {
        let totalRuns = runs.count
        let runsDble = Double(totalRuns)
        return runsDble
    }
    
    func calculatePlansCompleted(plans: Double, swims: Double, rides: Double, runs: Double) -> String {
        let totalActivities = rides + runs + swims
        let plansCompleteProportion = (totalActivities / plans) * 100
        print(plansCompleteProportion)
        let proportionStr = String(format: "%.2f", plansCompleteProportion)
        return proportionStr
    }
    
}

