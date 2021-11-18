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
    
    static func pace(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    static func speed(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    
    static func date(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp as Date? else { return ""}
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: timestamp)
    }
    
    
}

