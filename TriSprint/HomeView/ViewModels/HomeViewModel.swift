//
//  HomeViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? ""
    @Published var totalNumberofPlans = 0.0
    @Published var plansCompleted = ""
    @Published var swimPlansTotal = 0.0
    @Published var swimPlansCompleted = 0.0
    @Published var ridePlansTotal = 0.0
    @Published var ridePlansCompleted = 0.0
    @Published var runPlansTotal = 0.0
    @Published var runPlansCompleted = 0.0
    @Published var proportionCompleted = 0.0
    @Published var currentProgress: CGFloat = 0.0
    @Published var swimProgress: CGFloat = 0.0
    @Published var rideProgress: CGFloat = 0.0
    @Published var runProgress: CGFloat = 0.0
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
    
    func calculateTotals(plans: FetchedResults<Plan>,swims: FetchedResults<Swim>,rides: FetchedResults<Ride>,runs: FetchedResults<Run>) {
        let plansCount = plans.count
        totalNumberofPlans = Double(plansCount)
        let swimCount = swims.count
        swimPlansCompleted = Double(swimCount)
        let rideTotal = rides.count
        ridePlansCompleted = Double(rideTotal)
        let runTotal = runs.count
        runPlansCompleted = Double(runTotal)
        let activityTotal = Double(swimCount + rideTotal + runTotal)
        let plansCompleteProportion = (activityTotal / Double(plansCount)) * 100
        if Double(plansCount) < activityTotal {
            proportionCompleted = 0.0
        } else {
            proportionCompleted = plansCompleteProportion
        }
    
        calculateProgress(swimsCompleted: swimPlansCompleted, ridesCompleted: ridePlansCompleted, runsCompleted: runPlansCompleted, plans: plans)
      
    }
    
    func calculateProgress(swimsCompleted: Double, ridesCompleted: Double, runsCompleted: Double, plans: FetchedResults<Plan>) {
        for plan in plans {
            if plan.session == Sessions.swim.rawValue {
                swimPlansTotal += 1
            } else if plan.session == Sessions.ride.rawValue {
                ridePlansTotal += 1
            } else if plan.session == Sessions.run.rawValue {
                runPlansTotal += 1
            } else if plan.session == Sessions.rideRun.rawValue {
                ridePlansTotal += 1
                runPlansTotal += 1
            }
        }
        swimProgress = swimsCompleted / swimPlansTotal
        rideProgress = ridesCompleted / ridePlansTotal
        runProgress = runsCompleted / runPlansTotal
        print("Nige: progress swim = \(swimProgress), ride = \(rideProgress), run = \(rideProgress)")
    }
    
    func calculateFastest(swims: FetchedResults<Swim>,rides: FetchedResults<Ride>,runs: FetchedResults<Run>) {
        var swimSpeedArray = [Double]()
        guard let latestSwim = swims.first else { return }
        let latestSwimDistance = latestSwim.distance / 1.609
        for swim in swims {
            let swimDistance = swim.distance
            let swimDuration = swim.duration
            let swimSpeed = (swimDistance / 1.609) / (Double(swimDuration) / 3600)
            swimSpeedArray.append(swimSpeed)
        }
        guard let fastestSwim = swimSpeedArray.max() else { return }
        print("Nige: fastest swim = \(fastestSwim), latest swim distance = \(latestSwimDistance)")
    }
    

   
  
    
}

