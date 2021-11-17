//
//  TrainingDetailView.swift
//  TriSprint
//
//  Created by Nigel Karan on 16.11.21.
//

import SwiftUI

struct TrainingDetailView: View {
    @Binding var plan: Plan
    @ObservedObject var scheduleVm = ScheduleViewModel()
    @State private var imageName: String?
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        DetailContentView(plan: $plan)
        
    }
  
}



