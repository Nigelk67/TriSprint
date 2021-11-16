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
//    @State private var time: String
//    @State private var rpe: String
//    @State private var description: String
    @State private var showBrickSession = false
    
    var body: some View {
        ZStack {
            BikeBackground()
            VStack {
                cancelButton
                Text("Day: \(plan.day ?? "")")
                    .foregroundColor(Color.mainText)
                    .font(.title)
                
                HStack {
                    Image(imageName ?? "Training_Full")
                    VStack {
                        Text("Time")
                        //Text(time)
                    }
                    VStack {
                        Text("RPE")
                        //Text(rpe)
                    }
                }
                //Text(description)
            }
        }
        .onAppear {
            imageName = scheduleVm.setImageNames(session: plan.session ?? "", completed: plan.completed)
            //setVariables()
        }
        
    }
    private var cancelButton: some View {
        HStack {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
            //Spacer()
        }
    }
    
//    private func setVariables() {
//        if plan.session == Sessions.rideRun.rawValue {
//            showBrickSession = true
//        }
//        if plan.session == Sessions.swim.rawValue {
//            time = plan.swimTime ?? ""
//            description = plan.swimDescription ?? ""
//            rpe = plan.swimRpe ?? ""
//        } else if plan.session == Sessions.ride.rawValue {
//            time = plan.rideTime ?? ""
//            description = plan.rideDescription ?? ""
//            rpe = plan.rideRpe ?? ""
//        } else if plan.session == Sessions.run.rawValue {
//            time = plan.runTime ?? ""
//            description = plan.runDescription ?? ""
//            rpe = plan.runRpe ?? ""
//        }
//    }
}


//struct TrainingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingDetailView(plan: Plan())
//    }
//}
