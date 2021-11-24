//
//  DetailContentView.swift
//  TriSprint
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct DetailContentView: View {
    
    @Binding var plan: Plan
    @State private var showMapView = false
    @State private var showManualEntryView = false
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(plan: $plan)
                VStack {
                    DayView(day: plan.day ?? "")
                        .padding(.vertical, 30)
                    
                    ScrollView {
                        VStack {
                            HStack {
                                SkipButton()
                                EnterManuallyButton(showManualEnterView: $showManualEntryView)
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
                            
                            NavigationLink(destination: EnterManualView(plan: $plan), isActive: $showManualEntryView) { EmptyView() }
                            
                            NavigationLink(destination: MapView(plan: $plan), isActive: $showMapView) { EmptyView() }
                            
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
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
        }
    }
    
}

extension DetailContentView {
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


struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailContentView(plan: .constant(Plan()))
    }
}
