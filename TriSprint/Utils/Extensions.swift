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

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func generateRandomString(stringLength: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvw1234567890"
        return String((0..<stringLength).map{_ in letters.randomElement()! })
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

enum IconImageNames: String {
    case runIcon = "Icon_run"
    case rideIcon = "Icon_bike"
    case swimIcon = "Icon_swimF"
}

enum ReviewDay: String {
    case one = "5"
    case two = "15"
    case three = "34"
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

enum Activity: String, CaseIterable {
    case swim = "Swim"
    case ride = "Ride"
    case run = "Run"
}

enum Measure: String, CaseIterable {
    case kilometers = "Kilometers"
    case miles = "Miles"
}

enum AppStor: String, CaseIterable {
    case signedIn = "signedIn"
    case measure = "measure"
    case onboarded = "onboarded"
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
    static let startingSpan = MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
}


extension UnitSpeed {
    class var secondsPerMeter: UnitSpeed {
        return UnitSpeed(symbol: "sec/mtr", converter: UnitConverterPace(coefficient: 1))
    }
    
    class var minutesPerKilometer: UnitSpeed {
        return UnitSpeed(symbol: "min/km", converter: UnitConverterPace(coefficient: 60 / 1000))
    }
    
    class var minutesPerMile: UnitSpeed {
        return UnitSpeed(symbol: "min/mi", converter: UnitConverterPace(coefficient: 60 / 1609.34))
    }
    
    class var milesPerHour: UnitSpeed {
        return UnitSpeed(symbol: "mi/hr", converter: UnitConverterInverse(coefficient: 1609.34 / 3600))
    }
    
    class var kilometersPerHour: UnitSpeed {
        return UnitSpeed(symbol: "km/hr", converter: UnitConverterInverse(coefficient: 1000 / 3600))
    }
    
}
