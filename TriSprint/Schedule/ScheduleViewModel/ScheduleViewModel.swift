//
//  ScheduleViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 15.11.21.
//

import SwiftUI

class ScheduleViewModel: ObservableObject {
    
    func setImageNames(session: String, completed: Int16) -> String {
        var imageName = ""
        let sess = Sessions(rawValue: session)
        switch sess {
        case .swim:
            if completed == 1 {
                imageName = TrainingImageNames.trainingSwimCompleted.rawValue
            } else {
                imageName = TrainingImageNames.trainingSwim.rawValue
            }
            
        case .ride:
            print("Nige: setImages func - completed Ride = \(completed)")
            if completed == 1 {
                imageName = TrainingImageNames.trainingRideCompleted.rawValue
            } else {
                imageName = TrainingImageNames.trainingRide.rawValue
            }
            imageName = TrainingImageNames.trainingRide.rawValue
        case .run:
            if completed == 1 {
                imageName = TrainingImageNames.trainingRunCompleted.rawValue
            } else {
                imageName = TrainingImageNames.trainingRun.rawValue
            }
        case .rideRun:
            if completed == 1 {
                imageName = TrainingImageNames.bikeRunCompleted.rawValue
            } else {
                imageName = TrainingImageNames.brickBikeRun.rawValue
            }
        case .swimRide:
            if completed == 1 {
                imageName = TrainingImageNames.swimBikeCompleted.rawValue
            } else {
                imageName = TrainingImageNames.brickSwimBike.rawValue
            }
        case .swimRun:
            if completed == 1 {
                imageName = TrainingImageNames.swimRunCompleted.rawValue
            } else {
                imageName = TrainingImageNames.brickSwimRun.rawValue
            }
        case .full:
            if completed == 1 {
                imageName = TrainingImageNames.fullCompleted.rawValue
            } else {
                imageName = TrainingImageNames.trainingFull.rawValue
            }
        case .none:
            imageName = ""
        }
        return imageName
    }
    
    
    
}

