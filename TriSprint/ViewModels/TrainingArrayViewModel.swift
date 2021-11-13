//
//  TrainingArrayViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI
import Combine

class TrainingPlanArrayViewModel: ObservableObject {
    
    @Published var trainingPlan = Array<Dictionary<String, String>>()
    
    func fetchPlanArray(name: String) {
        let resource = "\(name)Day"
        let path = Bundle.main.path(forResource: resource, ofType: "plist")
        var array: NSArray?
        array = NSArray(contentsOfFile: path!)
        trainingPlan = array as! [Dictionary<String, String>]
    }
    
}
