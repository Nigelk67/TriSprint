//
//  LineChartViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 30.11.21.
//

import SwiftUI

class LineChartViewModel: ObservableObject {
    
    let measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? ""
    @Published var swimDistanceArrayReversed: [Double] = []
    @Published var swimDurationArray: [Double] = []
    @Published var swimSpeedArray: [Double] = []
    @Published var swimPaceArray: [Double] = []
    @Published var rideDistanceArray: [Double] = []
    @Published var rideDurationArray: [Double] = []
    @Published var rideSpeedArray: [Double] = []
    @Published var ridePaceArray: [Double] = []
    @Published var runDistanceArray: [Double] = []
    @Published var runDurationArray: [Double] = []
    @Published var runSpeedArray: [Double] = []
    @Published var runPaceArray: [Double] = []
    
    func createArraysForChart(swims: FetchedResults<Swim>, rides: FetchedResults<Ride>, runs: FetchedResults<Run>) {
        calculateSwim(swims: swims)
        calculateRun(runs: runs)
        calculateRide(rides: rides)
    }
    
    func calculateSwim(swims: FetchedResults<Swim>) {
        var distance = Double()
        var distArray = [Double]()
        var durationArray = [Double]()
        var speedArray = [Double]()
        var paceArray = [Double]()
        for each in swims {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            
            durationArray.append(durationInMins)
            swimDurationArray = durationArray.reversed()
            
            distArray.append(distance)
            swimDistanceArrayReversed = distArray.reversed()
            
            let speed = distance / (durationInSecs/3600)
            speedArray.append(speed)
            swimSpeedArray = speedArray.reversed()
            
            let pace = durationInMins / distance
            paceArray.append(pace)
            swimPaceArray = paceArray.reversed()
        }
    }
    
    func calculateRide(rides: FetchedResults<Ride>) {
        var distance = Double()
        var distArray = [Double]()
        var durationArray = [Double]()
        var speedArray = [Double]()
        var paceArray = [Double]()
        for each in rides {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            
            durationArray.append(durationInMins)
            rideDurationArray = durationArray.reversed()
            
            distArray.append(distance)
            rideDistanceArray = distArray.reversed()
            
            let speed = distance / (durationInSecs/3600)
            speedArray.append(speed)
            rideSpeedArray = speedArray.reversed()
            
            let pace = durationInMins / distance
            paceArray.append(pace)
            ridePaceArray = paceArray.reversed()
        }
    }
    
    func calculateRun(runs: FetchedResults<Run>) {
        var distance = Double()
        var distArray = [Double]()
        var durationArray = [Double]()
        var speedArray = [Double]()
        var paceArray = [Double]()
        for each in runs {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            
            durationArray.append(durationInMins)
            runDurationArray = durationArray.reversed()
            
            distArray.append(distance)
            runDistanceArray = distArray.reversed()
            
            let speed = distance / (durationInSecs/3600)
            speedArray.append(speed)
            runSpeedArray = speedArray.reversed()
            
            let pace = durationInMins / distance
            paceArray.append(pace)
            runPaceArray = paceArray.reversed()
        }
    }
}
