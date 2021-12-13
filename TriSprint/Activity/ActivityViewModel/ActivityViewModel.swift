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
            updateLabelsInKm(distanceInMtrs: ride.distance, duration: ride.duration, timestamp: ride.timestamp, distanceLabel: &rideDistanceText, timeLabel: &rideTimeText, speedLabel: &rideSpeedText, paceLabel: &ridePaceText, dateLabel: &rideDateText)
            
        } else {
            updateLabelsInMiles(distanceInMtrs: ride.distance, duration: ride.duration, timestamp: ride.timestamp, distanceLabel: &rideDistanceText, timeLabel: &rideTimeText, speedLabel: &rideSpeedText, paceLabel: &ridePaceText, dateLabel: &rideDateText)
        }
    }
    
    func updateRuns(run: Run) {
        imageName = TrainingImageNames.trainingRun.rawValue
        if self.measure == Measure.kilometers.rawValue {
            updateLabelsInKm(distanceInMtrs: run.distance, duration: run.duration, timestamp: run.timestamp, distanceLabel: &runDistanceText, timeLabel: &runTimeText, speedLabel: &runSpeedText, paceLabel: &runPaceText, dateLabel: &runDateText)
        } else {
            updateLabelsInMiles(distanceInMtrs: run.distance, duration: run.duration, timestamp: run.timestamp, distanceLabel: &runDistanceText, timeLabel: &runTimeText, speedLabel: &runSpeedText, paceLabel: &runPaceText, dateLabel: &runDateText)
        }
    }
    
    func updateSwims(swim: Swim) {
        imageName = TrainingImageNames.trainingSwim.rawValue
        if self.measure == Measure.kilometers.rawValue {
            updateLabelsInKm(distanceInMtrs: swim.distance, duration: swim.duration, timestamp: swim.timestamp, distanceLabel: &swimDistanceText, timeLabel: &swimTimeText, speedLabel: &swimSpeedText, paceLabel: &swimPaceText, dateLabel: &swimDateText)
        } else {
            updateLabelsInMiles(distanceInMtrs: swim.distance, duration: swim.duration, timestamp: swim.timestamp, distanceLabel: &swimDistanceText, timeLabel: &swimTimeText, speedLabel: &swimSpeedText, paceLabel: &swimPaceText, dateLabel: &swimDateText)
        }
    }
    
    
    func updateLabelsInKm(distanceInMtrs: Double, duration: Int16, timestamp: Date?, distanceLabel: inout String, timeLabel: inout String, speedLabel: inout String, paceLabel: inout String, dateLabel: inout String) {
        let formattedDistance = FormatDisplay.kmDistance(distanceInMtrs)
        let formattedTime = FormatDisplay.time(Int(duration))
        let formattedPace = FormatDisplay.pacePerKmDble(distance: distanceInMtrs, seconds: duration, outputUnit: UnitSpeed.minutesPerKilometer)
        let formattedSpeed = FormatDisplay.speedKmph(distance: distanceInMtrs, seconds: duration, outputUnit: UnitSpeed.kilometersPerHour)
        let formattedDate = FormatDisplay.date(timestamp)
        distanceLabel = "\(formattedDistance)"
        timeLabel = "\(formattedTime)"
        speedLabel = "\(formattedSpeed)"
        paceLabel = "\(formattedPace)"
        dateLabel = "\(formattedDate)"
    }
    
    func updateLabelsInMiles(distanceInMtrs: Double, duration: Int16, timestamp: Date?, distanceLabel: inout String, timeLabel: inout String, speedLabel: inout String, paceLabel: inout String, dateLabel: inout String) {
        let formattedDistance = FormatDisplay.distanceInMiles(distanceInMtrs)
        let formattedTime = FormatDisplay.time(Int(duration))
        //let distanceInMiles = distance / 1.609
        let formattedPace = FormatDisplay.pacePerMileDble(distance: distanceInMtrs, seconds: duration, outputUnit: UnitSpeed.minutesPerMile)
        let formattedSpeed = FormatDisplay.speedMph(distance: distanceInMtrs, seconds: duration, outputUnit: UnitSpeed.milesPerHour)
        let formattedDate = FormatDisplay.date(timestamp)
        distanceLabel = "\(formattedDistance)"
        timeLabel = "\(formattedTime)"
        speedLabel = "\(formattedSpeed)"
        paceLabel = "\(formattedPace)"
        dateLabel = "\(formattedDate)"
    }
    
    
    
    
}
