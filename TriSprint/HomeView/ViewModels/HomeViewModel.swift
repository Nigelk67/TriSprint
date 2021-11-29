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
    @Published var currentSwimProgress: CGFloat = 0.0
    @Published var currentRideProgress: CGFloat = 0.0
    @Published var currentRunProgress: CGFloat = 0.0
    @Published var swimProgress: CGFloat = 0.0
    @Published var rideProgress: CGFloat = 0.0
    @Published var runProgress: CGFloat = 0.0
    @Published var swimSpeedLatest = "0"
    @Published var swimSpeedFastest = "0"
    @Published var rideSpeedLatest = "15.5"
    @Published var rideSpeedFastest = "14.3"
    @Published var runSpeedLatest = "4.5"
    @Published var runSpeedFastest = "4.2"
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
        resetProgress()
        for plan in plans {
            if plan.session == Sessions.swim.rawValue {
                self.swimPlansTotal += 1
            } else if plan.session == Sessions.ride.rawValue {
                self.ridePlansTotal += 1
            } else if plan.session == Sessions.run.rawValue {
                self.runPlansTotal += 1
            } else if plan.session == Sessions.rideRun.rawValue {
                self.ridePlansTotal += 1
                self.runPlansTotal += 1
            }
        }
        
        self.swimProgress = swimsCompleted / self.swimPlansTotal
        self.rideProgress = ridesCompleted / self.ridePlansTotal
        self.runProgress = runsCompleted / self.runPlansTotal
        
    }
    
    private func resetProgress() {
        swimPlansTotal = 0
        ridePlansTotal = 0
        runPlansTotal = 0
        currentSwimProgress = 0
        currentRideProgress = 0
        currentRunProgress = 0
    }
    
    func calculateFastest(swims: FetchedResults<Swim>,rides: FetchedResults<Ride>,runs: FetchedResults<Run>) {
        calcSwimSpeed(swims: swims)
    }
    
    
    func calcSwimSpeed(swims: FetchedResults<Swim>) {
        var swimSpeedArray = [Double]()
        guard let latestSwim = swims.first else { return }
        var latestSwimDistance = Double()
        var swimDistance = Double()
        if measure == Measure.kilometers.rawValue {
            latestSwimDistance = latestSwim.distance
        } else {
            latestSwimDistance = latestSwim.distance / 1.609
        }
        let latestSwimDuration = Double(latestSwim.duration) / 3600
        let latestSwimSpeed = latestSwimDistance / latestSwimDuration
        swimSpeedLatest = String(format: "%.2f",latestSwimSpeed)
        
        for swim in swims {
            if measure == Measure.kilometers.rawValue {
                swimDistance = swim.distance
            } else {
                swimDistance = swim.distance / 1.609
            }
            let swimDuration = swim.duration
            let swimSpeed = swimDistance / (Double(swimDuration) / 3600)
            swimSpeedArray.append(swimSpeed)
        }
        guard let fastestSwim = swimSpeedArray.max() else { return }
        swimSpeedFastest = String(format: "%.2f",fastestSwim)
    }
    
    
    

   
  
    
}

