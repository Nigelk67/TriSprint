//
//  FormatDisplay.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import Foundation

struct FormatDisplay {
    static func distance(_ distance: Double) -> String {
        let distanceMeasurement = Measurement(value: distance, unit: UnitLength.meters)
        return FormatDisplay.distance(distanceMeasurement)
    }
    
    static func distanceInMiles(_ distance: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let miles = (distance / 1000) / 1.609
        let distanceInMiles = Measurement(value: miles, unit: UnitLength.miles)
        formatter.unitStyle = .short
        return formatter.string(from: (distanceInMiles))
    }
    
    static func kmDistance(_ distance: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let distanceKm = Measurement(value: distance, unit: UnitLength.kilometers)
        formatter.unitStyle = .short
        return formatter.string(from: (distanceKm/1000))
    }
    
    static func distanceInKm(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let distanceKm = Measurement(value: distance.value, unit: UnitLength.kilometers)
        formatter.unitStyle = .short
        return formatter.string(from: (distanceKm/1000))
    }
    // Shows distance as miles:-
    static func distance(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        return formatter.string(from: distance)
    }
    
    
    static func time(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds))!
    }
    
    static func pacePerMile(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? Double(seconds / 60) / distance.value : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.minutesPerMile)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    static func pacePerKm(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? Double(seconds / 60) / distance.value : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.minutesPerKilometer)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    static func speedMph(distance: Double, seconds: Int16, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let hourTime = Double(seconds) / 3600
        let speedMagnitude = seconds != 0 ? distance / Double(hourTime) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.milesPerHour)
        return formatter.string(from: speed)
    }
    
    static func speedKmph(distance: Double, seconds: Int16, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let hourTime = Double(seconds) / 3600
        let speedMagnitude = seconds != 0 ? distance / Double(hourTime) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.kilometersPerHour)
        return formatter.string(from: speed)
    }
    
    static func pacePerMileDble(distance: Double, seconds: Int16, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? Double(seconds/60) / distance : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.minutesPerMile)
        return formatter.string(from: speed)
    }
    static func pacePerKmDble(distance: Double, seconds: Int16, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? Double(seconds/60) / distance : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.minutesPerKilometer)
        return formatter.string(from: speed)
    }
    
    
    static func date(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp as Date? else { return ""}
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: timestamp)
    }
    
    
}

