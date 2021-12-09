//
//  HomeViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @AppStorage(AppStor.measure.rawValue) var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? Measure.kilometers.rawValue
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
    @Published var swimLatestDistance: Double = 0
    @Published var swimLatestDurationInHours: Double = 0
    @Published var swimLatestDurationInMins: Double = 0
    @Published var rideLatestDistance: Double = 0
    @Published var rideLatestDurationInHours: Double = 0
    @Published var rideLatestDurationInMins: Double = 0
    @Published var runLatestDistance: Double = 0
    @Published var runLatestDurationInHours: Double = 0
    @Published var runLatestDurationInMins: Double = 0
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
        //setLatestSwim(swims: swims)
        setSwims(swims: swims)
        setRides(rides: rides)
        setRuns(runs: runs)
//        calcRideSpeed(rides: rides)
//        calcRunSpeed(runs: runs)
        calculateSwimSpeedVariances()
        calculateRideSpeedVariances()
        calculateRunSpeedVariances()
    }
    
    
    private func setSwims(swims: FetchedResults<Swim>) {
        setLatestSwim(swims: swims)
        calcSwimPaceLatest(swims: swims)
        calcSwimSpeedLatest(swims: swims)
        calcSwimFastest(swims: swims)
    }
    
    private func setRides(rides: FetchedResults<Ride>) {
        setLatestRide(rides: rides)
        calcRidePaceLatest(rides: rides)
        calcRideSpeedLatest(rides: rides)
        calcRideFastest(rides: rides)
    }
    
    private func setRuns(runs: FetchedResults<Run>) {
        setLatestRun(runs: runs)
        calcRunPaceLatest(runs: runs)
        calcRunSpeedLatest(runs: runs)
        calcRunFastest(runs: runs)
    }
    
    //MARK: Set Latest functions
    private func setLatestSwim(swims: FetchedResults<Swim>) {
        guard let latest = swims.first else { return }
        let latestDist = latest.distance
        let latestDuration = Double(latest.duration)
        if measure == Measure.kilometers.rawValue {
            swimLatestDistance = latestDist
        } else {
            swimLatestDistance = latestDist / 1.609
        }
        swimLatestDurationInHours = latestDuration / 3600
        swimLatestDurationInMins = latestDuration / 60
    }
    
    private func setLatestRide(rides: FetchedResults<Ride>) {
        guard let latest = rides.first else { return }
        let latestDist = latest.distance
        let latestDuration = Double(latest.duration)
        if measure == Measure.kilometers.rawValue {
            rideLatestDistance = latestDist
        } else {
            rideLatestDistance = latestDist / 1.609
        }
        rideLatestDurationInHours = latestDuration / 3600
        rideLatestDurationInMins = latestDuration / 60
    }
    
    private func setLatestRun(runs: FetchedResults<Run>) {
        guard let latest = runs.first else { return }
        let latestDist = latest.distance
        let latestDuration = Double(latest.duration)
        if measure == Measure.kilometers.rawValue {
            runLatestDistance = latestDist
        } else {
            runLatestDistance = latestDist / 1.609
        }
        runLatestDurationInHours = latestDuration / 3600
        runLatestDurationInMins = latestDuration / 60
    }
    
    
    
    //MARK: Pace Functions
    private func calcSwimPaceLatest(swims: FetchedResults<Swim>) {
        let latestPace = swimLatestDurationInMins / swimLatestDistance
        swimPaceLatest = String(format: "%.2f", latestPace)
    }
    private func calcRidePaceLatest(rides: FetchedResults<Ride>) {
        let latestPace = rideLatestDurationInMins / rideLatestDistance
        ridePaceLatest = String(format: "%.2f", latestPace)
    }
    private func calcRunPaceLatest(runs: FetchedResults<Run>) {
        let latestPace = runLatestDurationInMins / runLatestDistance
        runPaceLatest = String(format: "%.2f", latestPace)
    }
    
    //MARK: Speed Functions
    private func calcSwimSpeedLatest(swims: FetchedResults<Swim>) {
        let latestSpeed = swimLatestDistance / swimLatestDurationInHours
        swimSpeedLatest = String(format: "%.2f",latestSpeed)
    }
    private func calcRideSpeedLatest(rides: FetchedResults<Ride>) {
        let latestSpeed = rideLatestDistance / rideLatestDurationInHours
        rideSpeedLatest = String(format: "%.2f",latestSpeed)
    }
    private func calcRunSpeedLatest(runs: FetchedResults<Run>) {
        let latestSpeed = runLatestDistance / runLatestDurationInHours
        runSpeedLatest = String(format: "%.2f",latestSpeed)
    }
    
    //MARK: Fastest Functions
    private func calcSwimFastest(swims: FetchedResults<Swim>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
        var distance = Double()
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
    
    private func calcRideFastest(rides: FetchedResults<Ride>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
        var distance = Double()
       
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
    
  
    private func calcRunFastest(runs: FetchedResults<Run>) {
        var speedArray = [Double]()
        var paceArray = [Double]()
        var distance = Double()
    
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
    
    //MARK: Variance Functions
    private func calculateSwimSpeedVariances() {
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
    }
    
    private func calculateRideSpeedVariances() {
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
    }
    
    private func calculateRunSpeedVariances() {
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
    
//    private func calculateSpeedVariances() {
//        guard let swimLatestDble = Double(swimSpeedLatest), let swimFastestDble = Double(swimSpeedFastest) else { return }
//        let swimVarianceDble = ((swimLatestDble - swimFastestDble)/swimLatestDble) * 100
//        if swimVarianceDble < 0 {
//            isSwimSpeedNegative = true
//        }
//        swimSpeedVariance = String(format: "%.1f", swimVarianceDble)
//        guard let swimPaceLatestDble = Double(swimPaceLatest), let swimPaceFastestDble = Double(swimPaceFastest) else { return }
//        let swimPaceVarianceDble = ((swimPaceFastestDble - swimPaceLatestDble)/swimPaceFastestDble) * 100
//        if swimPaceVarianceDble < 0 {
//            isSwimPaceNegative = true
//        }
//        swimPaceVariance = String(format: "%.1f", swimPaceVarianceDble)
        
//        guard let rideLatestDble = Double(rideSpeedLatest), let rideFastestDble = Double(rideSpeedFastest) else { return }
//        let rideVarianceDble = ((rideLatestDble - rideFastestDble)/rideLatestDble) * 100
//        if rideVarianceDble < 0 {
//            isRideSpeedNegative = true
//        }
//        rideSpeedVariance = String(format: "%.1f", rideVarianceDble)
//        guard let ridePaceLatestDble = Double(ridePaceLatest), let ridePaceFastestDble = Double(ridePaceFastest) else { return }
//        let ridePaceVarianceDble = ((ridePaceFastestDble - ridePaceLatestDble)/ridePaceFastestDble) * 100
//        if ridePaceVarianceDble < 0 {
//            isRidePaceNegative = true
//        }
//        ridePaceVariance = String(format: "%.1f", ridePaceVarianceDble)
        
//        guard let runLatestDble = Double(runSpeedLatest), let runFastestDble = Double(runSpeedFastest) else { return }
//        let runVarianceDble = ((runLatestDble - runFastestDble)/runLatestDble) * 100
//        if runVarianceDble < 0 {
//            isRunSpeedNegative = true
//        }
//        runSpeedVariance = String(format: "%.1f", runVarianceDble)
//
//        guard let runPaceLatestDble = Double(runPaceLatest), let runPaceFastestDble = Double(runPaceFastest) else { return }
//        let runPaceVarianceDble = ((runPaceFastestDble - runPaceLatestDble)/runPaceFastestDble) * 100
//        if runPaceVarianceDble < 0 {
//            isRunPaceNegative = true
//        }
//        runPaceVariance = String(format: "%.1f", runPaceVarianceDble)
//    }
    
    
}

