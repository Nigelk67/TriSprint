//
//  TrainingPlan.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI

struct TrainingPlan {
    let week: Int
    let day: String
    let phase: String
    let session: String
    let completed: Int
    let swimTime: String
    let swimRpe: String
    let swimDescription: String
    let rideTime: String
    let rideRpe: String
    let rideDescription: String
    let runTime: String
    let runRpe: String
    let runDescription: String
    
    init(dictionary: [String: Any]) {
        self.week = dictionary["week"] as? Int ?? 0
        self.day = dictionary["day"] as? String ?? ""
        self.phase = dictionary["phase"] as? String ?? ""
        self.session = dictionary["session"] as? String ?? ""
        self.completed = dictionary["completed"] as? Int ?? 0
        self.swimTime = dictionary["swimtime"] as? String ?? ""
        self.swimRpe = dictionary["swimrpe"] as? String ?? ""
        self.swimDescription = dictionary["swimdescription"] as? String ?? ""
        self.rideTime = dictionary["ridetime"] as? String ?? ""
        self.rideRpe = dictionary["riderpe"] as? String ?? ""
        self.rideDescription = dictionary["ridedescription"] as? String ?? ""
        self.runTime = dictionary["runtime"] as? String ?? ""
        self.runRpe = dictionary["runrpe"] as? String ?? ""
        self.runDescription = dictionary["rundescription"] as? String ?? ""
    }
}
