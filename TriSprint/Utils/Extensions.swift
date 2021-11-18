//
//  Extensions.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI
import MapKit

extension Color {
    static var accentButton: Color {
        Color("AccentButton")
    }
    static var mainButton: Color {
        Color("MainButton")
    }
    static var iconGreen: Color {
        Color("IconGreen")
    }
    static var mainBackground: Color {
        Color("MainBackground")
    }
    static var mainText: Color {
        Color("MainText")
    }
}

extension Image {
    static var trainingRide: Image {
        Image("Training_Ride")
    }
    static var trainingRun: Image {
        Image("Training_Run")
    }
    static var trainingSwim: Image {
        Image("Training_Swim")
    }
}

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case pList = "Plist"
        case first = "First"
        case fitnessLevel = "FitnessLevel"
        case trainingDays = "TrainingDays"
    }
    
}

enum TrainingImageNames: String {
    case trainingSwim = "Training_Swim"
    case trainingSwimCompleted = "Training_Swim_Complete"
    case trainingRide = "Training_Ride"
    case trainingRideCompleted = "Training_Ride_Complete"
    case trainingRun = "Training_Run"
    case trainingRunCompleted = "Training_Run_Complete"
    case brickBikeRun = "Brick_BikeRun"
    case bikeRunCompleted = "Brick_BikeRun_Complete"
    case brickSwimBike = "Brick_SwimBike"
    case swimBikeCompleted = "Brick_SwimBike_Complete"
    case brickSwimRun = "Brick_SwimRun"
    case swimRunCompleted = "Brick_SwimRun_Complete"
    case trainingFull = "Training_Full"
    case fullCompleted = "Training_Full_Complete"
}

enum Sessions: String {
    case swim = "Swim"
    case ride = "Ride"
    case run = "Run"
    case rideRun = "RideRun"
    case swimRide = "SwimRide"
    case swimRun = "SwimRun"
    case full = "Full"
}

extension HorizontalAlignment {
    private enum HCenterAlignment: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            return dimensions[HorizontalAlignment.center]
        }
    }
    static let hCentered = HorizontalAlignment(HCenterAlignment.self)
}

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let startingSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}
