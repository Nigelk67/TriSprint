//
//  ScheduleViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 15.11.21.
//

import SwiftUI

class ScheduleViewModel: ObservableObject {
    
    func setImageNames(session: String) -> String {
        var imageName = ""
        let sess = Sessions(rawValue: session)
        switch sess {
        case .swim:
            imageName = TrainingImageNames.trainingSwim.rawValue
        case .ride:
            imageName = TrainingImageNames.trainingRide.rawValue
        case .run:
            imageName = TrainingImageNames.trainingRun.rawValue
        case .brick:
            imageName = TrainingImageNames.brickBikeRun.rawValue
        case .none:
            imageName = ""
        }
        return imageName
    }
}

