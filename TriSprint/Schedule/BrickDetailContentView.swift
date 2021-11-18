//
//  BrickDetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct BrickDetailContentView: View {
    
    @Binding var plan: Plan
    @State private var showMapView: Bool = false
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(plan: $plan)
                VStack {
                    DayView(day: plan.day ?? "")
                        .padding(.vertical, 30)
                    Spacer()
                    ScrollView {
                        RideStack(plan: $plan, showMapView: $showMapView)
                        RunStack(plan: $plan, showMapView: showMapView)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
        }
        
    }
}

struct RideStack: View {
    @Binding var plan: Plan
    @Binding var showMapView: Bool
    var body: some View {
        VStack {
            HStack {
                SkipButton()
                EnterManuallyButton()
            }
            HStack {
                Image(TrainingImageNames.trainingRide.rawValue)
                    .padding(.horizontal, 10)
                Spacer()
                TimeView(minutes: plan.rideTime ?? "")
                Spacer()
                RpeView(rpe: plan.rideRpe ?? "")
            }
            .padding(.horizontal,0)
            .padding(.vertical,20)
            
            DescriptionView(description: plan.rideDescription ?? "")
            
            if plan.session == Sessions.swim.rawValue {
                LetsGoButton(isDisabled: true, showMapView: $showMapView)
                    .padding(.bottom)
            } else {
                LetsGoButton(isDisabled: false, showMapView: $showMapView)
                    .padding(.bottom)
            }
    
        }
        .frame(width: 350)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
    }
}

struct RunStack: View {
    @Binding var plan: Plan
    @State var showMapView: Bool
    var body: some View {
        VStack {
            HStack {
                SkipButton()
                EnterManuallyButton()
            }
            HStack {
                Image(TrainingImageNames.trainingRun.rawValue)
                    .padding(.horizontal, 10)
                Spacer()
                TimeView(minutes: plan.runTime ?? "")
                Spacer()
                RpeView(rpe: plan.runRpe ?? "")
            }
            .padding(.horizontal,0)
            .padding(.vertical,20)
            
            DescriptionView(description: plan.runDescription ?? "")
            
            if plan.session == Sessions.swim.rawValue {
                LetsGoButton(isDisabled: true, showMapView: $showMapView)
                    .padding(.bottom)
            } else {
                LetsGoButton(isDisabled: false, showMapView: $showMapView)
                    .padding(.bottom)
            }
        }
        .frame(width: 350)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
    }
}

struct BrickDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        BrickDetailContentView(plan: .constant(Plan()))
    }
}
