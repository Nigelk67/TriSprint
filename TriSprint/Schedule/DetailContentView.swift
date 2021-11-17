//
//  DetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct DetailContentView: View {
    
    @Binding var plan: Plan
    
    var body: some View {
        
        ZStack {
            BackgroundView(plan: $plan)
            
            VStack {
                CancelButton()
                DayView(day: plan.day ?? "")
                Spacer()
                ScrollView {
                    VStack {
                        HStack {
                            SkipButton()
                            EnterManuallyButton()
                        }
                        HStack {
                            ImageDetailView(session: plan.session ?? "", completed: plan.completed)
                            Spacer()
                            setTime()
                            Spacer()
                            setRpe()
                        }
                        .padding(.horizontal,0)
                        .padding(.vertical,20)
                        
                        setDescription()
                        
                        LetsGoButton()
                            .padding(.bottom)
                    }
                    .frame(width: 350)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                }
            }
        }
    }
    private func setTime() -> TimeView {
        if plan.session == Sessions.swim.rawValue {
            let time = plan.swimTime
            return TimeView(minutes: time ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let time = plan.rideTime
            return TimeView(minutes: time ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let time = plan.runTime
            return TimeView(minutes: time ?? "")
        }
        return TimeView(minutes: "")
    }
    
    private func setRpe() -> RpeView {
        if plan.session == Sessions.swim.rawValue {
            let rpe = plan.swimRpe
            return RpeView(rpe: rpe ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let rpe = plan.rideRpe
            return RpeView(rpe: rpe ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let rpe = plan.runRpe ?? ""
            return RpeView(rpe: rpe)
        }
        return RpeView(rpe: "")
    }
    
    private func setDescription() -> DescriptionView {
        if plan.session == Sessions.swim.rawValue {
            let desc = plan.swimDescription
            return DescriptionView(description: desc ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let desc = plan.rideDescription
            return DescriptionView(description: desc ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let desc = plan.runDescription
            return DescriptionView(description: desc ?? "")
        }
        return DescriptionView(description: "")
    }
    
    
}

struct BackgroundView: View {
    @Binding var plan: Plan
    @ViewBuilder
    var body: some View {
        if plan.session == Sessions.swim.rawValue {
            SwimBackground()
        } else if plan.session == Sessions.ride.rawValue {
            BikeBackground()
        } else if plan.session == Sessions.run.rawValue {
            RunBackground()
        }
    }
}


struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailContentView(plan: .constant(Plan()))
    }
}
