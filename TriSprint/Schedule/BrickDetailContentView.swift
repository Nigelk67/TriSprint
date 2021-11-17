//
//  BrickDetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct BrickDetailContentView: View {
    
    @Binding var plan: Plan
    
    var body: some View {
        ZStack {
            BackgroundView(plan: $plan)
            VStack {
                DayView(day: plan.day ?? "")
                Spacer()
                ScrollView {
                    RideStack(plan: $plan)
                    RunStack(plan: $plan)
                }
                CancelButton()
            }
            
        }
        
    }
}

struct RideStack: View {
    @Binding var plan: Plan
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
            
            LetsGoButton()
                .padding(.bottom)
        }
        .frame(width: 350)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
    }
}

struct RunStack: View {
    @Binding var plan: Plan
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
            
            LetsGoButton()
                .padding(.bottom)
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
