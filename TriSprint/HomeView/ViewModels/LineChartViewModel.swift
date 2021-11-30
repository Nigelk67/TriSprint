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
        calculateRuns(runs: runs)
        calculateRides(rides: rides)
    }
    
    func calculateSwim(swims: FetchedResults<Swim>) {
        var distance = Double()
        var array = [Double]()
        for each in swims {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            swimDurationArray.append(durationInMins)
            array.append(distance)
            swimDistanceArrayReversed = array.reversed()
            
            let speed = distance / (durationInSecs/3600)
            swimSpeedArray.append(speed)
            let pace = durationInMins / distance
            swimPaceArray.append(pace)
            
          
        }
        
    }
    
    func calculateRides(rides: FetchedResults<Ride>) {
        var distance = Double()
        for each in rides {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            rideDurationArray.append(durationInMins)
            rideDistanceArray.append(distance)
            
            let speed = distance / (durationInSecs/3600)
            rideSpeedArray.append(speed)
            let pace = durationInMins / distance
            ridePaceArray.append(pace)
        }
       
    }
    
    
    func calculateRuns(runs: FetchedResults<Run>) {
        var distance = Double()
        for each in runs {
            if measure == Measure.kilometers.rawValue {
                distance = each.distance
            } else {
                distance = each.distance / 1.609
            }
            let durationInSecs = Double(each.duration)
            let durationInMins = durationInSecs/60
            runDurationArray.append(durationInMins)
            runDistanceArray.append(distance)
            
            let speed = distance / (durationInSecs/3600)
            runSpeedArray.append(speed)
            let pace = durationInMins / distance
            runPaceArray.append(pace)
        }
       
    }
}
