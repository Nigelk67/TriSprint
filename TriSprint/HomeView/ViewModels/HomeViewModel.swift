//
//  HomeViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
   
    @AppStorage("measure") var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? Measure.kilometers.rawValue
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
    @Published var swimPaceLatest = "0"
    @Published var swimPaceFastest = "0"
    @Published var ridePaceLatest = "0"
    @Published var ridePaceFastest = "0"
    @Published var runPaceLatest = "0"
    @Published var runPaceFastest = "0"
    @Published var swimSpeedVariance = ""
    @Published var rideSpeedVariance = ""
    @Published var runSpeedVariance = ""
    @Published var isSwimSpeedNegative: Bool = false
    @Published var isRideSpeedNegative: Bool = false
    @Published var isRunSpeedNegative: Bool = false
    @Published var swimPaceVariance = ""
    @Published var ridePaceVariance = ""
    @Published var runPaceVariance = ""
    @Published var isSwimPaceNegative: Bool = false
    @Published var isRidePaceNegative: Bool = false
    @Published var isRunPaceNegative: Bool = false
    
    
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
            proportionCompleted = 0.1
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
        if swimsCompleted > self.swimPlansTotal || swimsCompleted == 0 {
            swimProgress = 0
        } else {
            self.swimProgress = swimsCompleted / self.swimPlansTotal
        }
        if ridesCompleted > self.ridePlansTotal || ridesCompleted == 0 {
            self.rideProgress = 0
        } else {
            self.rideProgress = ridesCompleted / self.ridePlansTotal
        }
        if runsCompleted > runPlansTotal || runsCompleted == 0 {
            self.runProgress = 0
        } else {
            self.runProgress = runsCompleted / self.runPlansTotal
        }
        
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
        calculateSpeedVariances()
    }
    //MARK: Speed Functions
    private func calcSwimSpeed(swims: FetchedResults<Swim>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
        guard let latest = swims.first else { return }
        var latestDistance = Double()
        var distance = Double()
        if measure == Measure.kilometers.rawValue {
            latestDistance = latest.distance
        } else {
            latestDistance = latest.distance / 1.609
        }
        let latestDuration = Double(latest.duration) / 3600
        let latestDurationInMinutes = Double(latest.duration) / 60
        let latestSpeed = latestDistance / latestDuration
        let latestPace = latestDurationInMinutes / latestDistance
        swimSpeedLatest = String(format: "%.2f",latestSpeed)
        swimPaceLatest = String(format: "%.2f", latestPace)
        
        for each in swims {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let duration = each.duration
            let durationInMins = each.duration / 60
            let speed = distance / (Double(duration) / 3600)
            let pace = Double(durationInMins) / distance
            speedArray.append(speed)
            paceArray.append(pace)
        }
        guard let fastest = speedArray.max() else { return }
        guard let fastestPace = paceArray.min() else { return }
        swimSpeedFastest = String(format: "%.2f",fastest)
        swimPaceFastest = String(format: "%.2f",fastestPace)
    }
    
    private func calcRideSpeed(rides: FetchedResults<Ride>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
        guard let latest = rides.first else { return }
        var latestDistance = Double()
        var distance = Double()
        if measure == Measure.kilometers.rawValue {
            latestDistance = latest.distance
        } else {
            latestDistance = latest.distance / 1.609
        }
        let latestDurationInMinutes = Double(latest.duration) / 60
        let latestPace = latestDurationInMinutes / latestDistance
        let latestDuration = Double(latest.duration) / 3600
        let latestSpeed = latestDistance / latestDuration
        rideSpeedLatest = String(format: "%.2f",latestSpeed)
        ridePaceLatest = String(format: "%.2f", latestPace)
        
        for each in rides {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let duration = each.duration
            let durationInMins = each.duration / 60
            let speed = distance / (Double(duration) / 3600)
            let pace = Double(durationInMins) / distance
            speedArray.append(speed)
            paceArray.append(pace)
        }
        guard let fastest = speedArray.max() else { return }
        guard let fastestPace = paceArray.min() else { return }
        rideSpeedFastest = String(format: "%.2f",fastest)
        ridePaceFastest = String(format: "%.2f", fastestPace)
    }
    
    private func calcRunSpeed(runs: FetchedResults<Run>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
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
        let latestDurationInMinutes = Double(latest.duration) / 60
        let latestPace = latestDurationInMinutes / latestDistance
        runSpeedLatest = String(format: "%.2f",latestSpeed)
        runPaceLatest = String(format: "%.2f",latestPace)
        
        for each in runs {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInMins = each.duration / 60
            let duration = each.duration
            let speed = distance / (Double(duration) / 3600)
            let pace = Double(durationInMins) / distance
            speedArray.append(speed)
            paceArray.append(pace)
        }
        guard let fastest = speedArray.max() else { return }
        guard let fastestPace = paceArray.min() else { return }
        runSpeedFastest = String(format: "%.2f",fastest)
        runPaceFastest = String(format: "%.2f", fastestPace)
    }
    
    private func calculateSpeedVariances() {
        guard let swimLatestDble = Double(swimSpeedLatest), let swimFastestDble = Double(swimSpeedFastest) else { return }
        let swimVarianceDble = ((swimLatestDble - swimFastestDble)/swimLatestDble) * 100
        if swimVarianceDble < 0 {
            isSwimSpeedNegative = true
        }
        swimSpeedVariance = String(format: "%.1f", swimVarianceDble)
        guard let swimPaceLatestDble = Double(swimPaceLatest), let swimPaceFastestDble = Double(swimPaceFastest) else { return }
        let swimPaceVarianceDble = ((swimPaceFastestDble - swimPaceLatestDble)/swimPaceFastestDble) * 100
        if swimPaceVarianceDble < 0 {
            isSwimPaceNegative = true
        }
        swimPaceVariance = String(format: "%.1f", swimPaceVarianceDble)
        
        guard let rideLatestDble = Double(rideSpeedLatest), let rideFastestDble = Double(rideSpeedFastest) else { return }
        let rideVarianceDble = ((rideLatestDble - rideFastestDble)/rideLatestDble) * 100
        if rideVarianceDble < 0 {
            isRideSpeedNegative = true
        }
        rideSpeedVariance = String(format: "%.1f", rideVarianceDble)
        guard let ridePaceLatestDble = Double(ridePaceLatest), let ridePaceFastestDble = Double(ridePaceFastest) else { return }
        let ridePaceVarianceDble = ((ridePaceFastestDble - ridePaceLatestDble)/ridePaceFastestDble) * 100
        if ridePaceVarianceDble < 0 {
            isRidePaceNegative = true
        }
        ridePaceVariance = String(format: "%.1f", ridePaceVarianceDble)
        
        guard let runLatestDble = Double(runSpeedLatest), let runFastestDble = Double(runSpeedFastest) else { return }
        let runVarianceDble = ((runLatestDble - runFastestDble)/runLatestDble) * 100
        if runVarianceDble < 0 {
            isRunSpeedNegative = true
        }
        runSpeedVariance = String(format: "%.1f", runVarianceDble)
        
        guard let runPaceLatestDble = Double(runPaceLatest), let runPaceFastestDble = Double(runPaceFastest) else { return }
        let runPaceVarianceDble = ((runPaceFastestDble - runPaceLatestDble)/runPaceFastestDble) * 100
        if runPaceVarianceDble < 0 {
            isRunPaceNegative = true
        }
        runPaceVariance = String(format: "%.1f", runPaceVarianceDble)
    }

    
}

