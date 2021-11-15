//
//  Extensions.swift
//  TriSprint
//
//  Created by Nigel Karan on 11.11.21.
//

import SwiftUI

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
    case trainingRide = "Training_Ride"
    case trainingRun = "Training_Run"
    case brickBikeRun = "Brick_BikeRun"
    case brickSwimBike = "Brick_SwimBike"
    case brickSwimRun = "Brick_SwimRun"
    case trainingFull = "Training_Full"
}

enum Sessions: String {
    case swim = "Swim"
    case ride = "Ride"
    case run = "Run"
    case brick = "RideRun"
}
