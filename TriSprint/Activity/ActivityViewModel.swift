//
//  ActivityViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var measure: String = "metr"
    @Published var rideDistanceText = "0.00"
    @Published var rideTimeText = "0.00"
    @Published var ridePaceText = "0.00"
    @Published var rideDateText = ""
    @Published var imageName = TrainingImageNames.trainingFull.rawValue
    @Published var runDistanceText = "0.00"
    @Published var runTimeText = "0.00"
    @Published var runPaceText = "0.00"
    @Published var runDateText = ""
    @Published var swimDistanceText = "0.00"
    @Published var swimTimeText = "0.00"
    @Published var swimPaceText = "0.00"
    @Published var swimDateText = ""
   
    
    func updateRides(ride: Ride) {
        imageName = TrainingImageNames.trainingRide.rawValue
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.kmDistance(ride.distance)
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            ridePaceText = "\(formattedPace)"
            rideDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distance((ride.distance))
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.speed(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            ridePaceText = "\(formattedPace)"
            rideDateText = "\(formattedDate)"
        }
    }
    


func updateRuns(run: Run) {
    imageName = TrainingImageNames.trainingRun.rawValue
    if self.measure == "metric" {
        let formattedDistance = FormatDisplay.kmDistance(run.distance)
        let formattedTime = FormatDisplay.time(Int(run.duration))
        let formattedPace = FormatDisplay.speed(distance: run.distance, seconds: run.duration, outputUnit: UnitSpeed.minutesPerKilometer)
        let formattedDate = FormatDisplay.date(run.timestamp)
        runDistanceText = "\(formattedDistance)"
        runTimeText = "\(formattedTime)"
        runPaceText = "\(formattedPace)"
        runDateText = "\(formattedDate)"
    } else {
        let formattedDistance = FormatDisplay.distance((run.distance))
        let formattedTime = FormatDisplay.time(Int(run.duration))
        let formattedPace = FormatDisplay.speed(distance: run.distance, seconds: run.duration, outputUnit: UnitSpeed.minutesPerMile)
        let formattedDate = FormatDisplay.date(run.timestamp)
        runDistanceText = "\(formattedDistance)"
        runTimeText = "\(formattedTime)"
        runPaceText = "\(formattedPace)"
        runDateText = "\(formattedDate)"
    }
}

    func updateSwims(swim: Swim) {
        imageName = TrainingImageNames.trainingSwim.rawValue
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.kmDistance(swim.distance)
            let formattedTime = FormatDisplay.time(Int(swim.duration))
            let formattedPace = FormatDisplay.speed(distance: swim.distance, seconds: swim.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(swim.timestamp)
            swimDistanceText = "\(formattedDistance)"
            swimTimeText = "\(formattedTime)"
            swimPaceText = "\(formattedPace)"
            swimDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distance((swim.distance))
            let formattedTime = FormatDisplay.time(Int(swim.duration))
            let formattedPace = FormatDisplay.speed(distance: swim.distance, seconds: swim.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(swim.timestamp)
            swimDistanceText = "\(formattedDistance)"
            swimTimeText = "\(formattedTime)"
            swimPaceText = "\(formattedPace)"
            swimDateText = "\(formattedDate)"
        }
    }
    
    
    
}
