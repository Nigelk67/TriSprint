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
    @Published var rideSpeedLatest = "0"
    @Published var rideSpeedFastest = "0"
    @Published var runSpeedLatest = "0"
    @Published var runSpeedFastest = "0"
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
        calcRideSpeed(rides: rides)
        calcRunSpeed(runs: runs)
    }
    
    
    func calcSwimSpeed(swims: FetchedResults<Swim>) {
        var speedArray = [Double]()
        guard let latest = swims.first else { return }
        var latestDistance = Double()
        var distance = Double()
        if measure == Measure.kilometers.rawValue {
            latestDistance = latest.distance
        } else {
            latestDistance = latest.distance / 1.609
        }
        let latestDuration = Double(latest.duration) / 3600
        let latestSpeed = latestDistance / latestDuration
        swimSpeedLatest = String(format: "%.2f",latestSpeed)
        
        for each in swims {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let duration = each.duration
            let speed = distance / (Double(duration) / 3600)
            speedArray.append(speed)
        }
        guard let fastest = speedArray.max() else { return }
        swimSpeedFastest = String(format: "%.2f",fastest)
    }
    
    func calcRideSpeed(rides: FetchedResults<Ride>) {
        var speedArray = [Double]()
        guard let latest = rides.first else { return }
        var latestDistance = Double()
        var distance = Double()
        if measure == Measure.kilometers.rawValue {
            latestDistance = latest.distance
        } else {
            latestDistance = latest.distance / 1.609
        }
        let latestDuration = Double(latest.duration) / 3600
        let latestSpeed = latestDistance / latestDuration
        rideSpeedLatest = String(format: "%.2f",latestSpeed)
        
        for each in rides {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let duration = each.duration
            let speed = distance / (Double(duration) / 3600)
            speedArray.append(speed)
        }
        guard let fastest = speedArray.max() else { return }
        rideSpeedFastest = String(format: "%.2f",fastest)
    }
    
    func calcRunSpeed(runs: FetchedResults<Run>) {
        var speedArray = [Double]()
        guard let latest = runs.first else { return }
        var latestDistance = Double()
        var distance = Double()
        if measure == Measure.kilometers.rawValue {
            latestDistance = latest.distance
        } else {
            latestDistance = latest.distance / 1.609
        }
        let latestDuration = Double(latest.duration) / 3600
        let latestSpeed = latestDistance / latestDuration
        runSpeedLatest = String(format: "%.2f",latestSpeed)
        
        for each in runs {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let duration = each.duration
            let speed = distance / (Double(duration) / 3600)
            speedArray.append(speed)
        }
        guard let fastest = speedArray.max() else { return }
        runSpeedFastest = String(format: "%.2f",fastest)
    }
    
    
    

   
  
    
}

