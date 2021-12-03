//
//  ActivityViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @AppStorage(AppStor.measure.rawValue) var measure: String?
    @Published var rideDistanceText = "0.00"
    @Published var rideTimeText = "0.00"
    @Published var ridePaceText = "0.00"
    @Published var rideSpeedText = "0.00"
    @Published var rideDateText = ""
    @Published var imageName = TrainingImageNames.trainingFull.rawValue
    @Published var runDistanceText = "0.00"
    @Published var runTimeText = "0.00"
    @Published var runPaceText = "0.00"
    @Published var runSpeedText = "0.00"
    @Published var runDateText = ""
    @Published var swimDistanceText = "0.00"
    @Published var swimTimeText = "0.00"
    @Published var swimSpeedText = "0.00"
    @Published var swimDateText = ""
    @Published var swimPaceText = "0.00"
    
    
    func updateRides(ride: Ride) {
        imageName = TrainingImageNames.trainingRide.rawValue
        if self.measure == Measure.kilometers.rawValue {
            let formattedDistance = FormatDisplay.kmDistance(ride.distance)
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let formattedPace = FormatDisplay.pacePerKmDble(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedSpeed = FormatDisplay.speedKmph(distance: ride.distance, seconds: ride.duration, outputUnit: UnitSpeed.kilometersPerHour)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            rideSpeedText = "\(formattedSpeed)"
            ridePaceText = "\(formattedPace)"
            rideDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distanceInMiles(ride.distance)
            let formattedTime = FormatDisplay.time(Int(ride.duration))
            let distanceInMiles = ride.distance / 1.609
            let formattedPace = FormatDisplay.pacePerMileDble(distance: distanceInMiles, seconds: ride.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedSpeed = FormatDisplay.speedMph(distance: distanceInMiles, seconds: ride.duration, outputUnit: UnitSpeed.milesPerHour)
            let formattedDate = FormatDisplay.date(ride.timestamp)
            rideDistanceText = "\(formattedDistance)"
            rideTimeText = "\(formattedTime)"
            ridePaceText = "\(formattedPace)"
            rideSpeedText = "\(formattedSpeed)"
            rideDateText = "\(formattedDate)"
        }
    }
    
    func updateRuns(run: Run) {
        imageName = TrainingImageNames.trainingRun.rawValue
        if self.measure == Measure.kilometers.rawValue {
            let formattedDistance = FormatDisplay.kmDistance(run.distance)
            let formattedTime = FormatDisplay.time(Int(run.duration))
            let formattedSpeed = FormatDisplay.speedKmph(distance: run.distance, seconds: run.duration, outputUnit: UnitSpeed.kilometersPerHour)
            let formattedPace = FormatDisplay.pacePerKmDble(distance: run.distance, seconds: run.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(run.timestamp)
            runDistanceText = "\(formattedDistance)"
            runTimeText = "\(formattedTime)"
            runPaceText = "\(formattedPace)"
            runSpeedText = "\(formattedSpeed)"
            runDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distanceInMiles(run.distance)
            let formattedTime = FormatDisplay.time(Int(run.duration))
            let distanceInMiles = run.distance / 1.609
            let formattedSpeed = FormatDisplay.speedMph(distance: distanceInMiles, seconds: run.duration, outputUnit: UnitSpeed.milesPerHour)
            let formattedPace = FormatDisplay.pacePerMileDble(distance: distanceInMiles, seconds: run.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(run.timestamp)
            runDistanceText = "\(formattedDistance)"
            runTimeText = "\(formattedTime)"
            runPaceText = "\(formattedPace)"
            runSpeedText = "\(formattedSpeed)"
            runDateText = "\(formattedDate)"
        }
    }
    
    func updateSwims(swim: Swim) {
        imageName = TrainingImageNames.trainingSwim.rawValue
        if self.measure == Measure.kilometers.rawValue {
            let formattedDistance = FormatDisplay.kmDistance(swim.distance)
            let formattedTime = FormatDisplay.time(Int(swim.duration))
            let formattedSpeed = FormatDisplay.speedKmph(distance: swim.distance, seconds: swim.duration, outputUnit: UnitSpeed.kilometersPerHour)
            let formattedPace = FormatDisplay.pacePerKmDble(distance: swim.distance, seconds: swim.duration, outputUnit: UnitSpeed.minutesPerKilometer)
            let formattedDate = FormatDisplay.date(swim.timestamp)
            swimDistanceText = "\(formattedDistance)"
            swimTimeText = "\(formattedTime)"
            swimSpeedText = "\(formattedSpeed)"
            swimPaceText = "\(formattedPace)"
            swimDateText = "\(formattedDate)"
        } else {
            let formattedDistance = FormatDisplay.distanceInMiles(swim.distance)
            let formattedTime = FormatDisplay.time(Int(swim.duration))
            let distanceInMiles = swim.distance / 1.609
            let formattedSpeed = FormatDisplay.speedMph(distance: distanceInMiles, seconds: swim.duration, outputUnit: UnitSpeed.milesPerHour)
            let formattedPace = FormatDisplay.pacePerMileDble(distance: distanceInMiles, seconds: swim.duration, outputUnit: UnitSpeed.minutesPerMile)
            let formattedDate = FormatDisplay.date(swim.timestamp)
            swimDistanceText = "\(formattedDistance)"
            swimTimeText = "\(formattedTime)"
            swimSpeedText = "\(formattedSpeed)"
            swimPaceText = "\(formattedPace)"
            swimDateText = "\(formattedDate)"
        }
    }
    
    
    
}
