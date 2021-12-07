//
//  BrickDetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct BrickDetailContentView: View {
    
    @Binding var plan: Plan
    //@Binding var showRatingsView: Bool
    @State private var showMapView: Bool = false
    @State private var showManualEntryView: Bool = false
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
                        RideStack(plan: $plan, showMapView: $showMapView, showManualEntryView: $showManualEntryView)
                        RunStack(plan: $plan, showMapView: showMapView, showManualEntryView: $showManualEntryView)
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
    @Binding var showManualEntryView: Bool
    //@Binding var showRatingsView: Bool
    var body: some View {
        VStack {
            HStack {
                SkipButton()
                EnterManuallyButton(showManualEnterView: $showManualEntryView)
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
            
            NavigationLink(destination: EnterManualView(plan: $plan, targetTime: plan.rideTime ?? ""), isActive: $showManualEntryView) { EmptyView() }
            
            NavigationLink(destination: MapView(plan: $plan, targetTime: plan.rideTime ?? "", targetRpe: plan.rideRpe ?? "", targetDesc: plan.rideDescription ?? "", session: "Ride"), isActive: $showMapView) { EmptyView()}
            
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
    @Binding var showManualEntryView: Bool
    //@Binding var showRatingsView: Bool
    var body: some View {
        VStack {
            HStack {
                SkipButton()
                EnterManuallyButton(showManualEnterView: $showManualEntryView)
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
            
            NavigationLink(destination: EnterManualView(plan: $plan, targetTime: plan.runTime ?? ""), isActive: $showManualEntryView) { EmptyView() }
            
            NavigationLink(destination: MapView(plan: $plan, targetTime: plan.runTime ?? "", targetRpe: plan.runRpe ?? "", targetDesc: plan.runDescription ?? "", session: "Run"), isActive: $showMapView) { EmptyView()}
            
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

//struct BrickDetailContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrickDetailContentView(plan: .constant(Plan()))
//    }
//}
