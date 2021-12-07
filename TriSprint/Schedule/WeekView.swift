//
//  WeekView.swift
//  TriSprint
//
//  Created by Nigel Karan on 16.11.21.
//

import SwiftUI

struct WeekView: View {
    
    var plans: FetchedResults<Plan>
    var week: Int
    //@State private var showDetailView = false
    @ObservedObject var scheduleVm = ScheduleViewModel()
    @State private var selectedPlan = Plan(entity: Plan.entity(), insertInto: nil)
    @State private var showBrickDetailView = false
    @State private var showSwimDetailView = false
    @State private var showRideDetailView = false
    @State private var showRunDetailView = false
    @State private var showRatingsView = false
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(plans) { plan in
                    if plan.week == week {
                        VStack {
                            HStack {
                                Text("Day")
                                Text(plan.day ?? "")
                            }
                            .foregroundColor(Color.mainText)
                            .font(.subheadline)
                            
                            Button {
                                selectedPlan = plan
                                setDetailView(session: plan.session ?? "")
                            } label: {
                                let imageName = scheduleVm.setImageNames(session: plan.session ?? "", completed: plan.completed)
                                Image(imageName)
                            }
                            .fullScreenCover(isPresented: $showBrickDetailView) {
                                BrickDetailContentView(plan: $selectedPlan)
                            }
                            .fullScreenCover(isPresented: $showSwimDetailView) {
                                DetailContentView(plan: $selectedPlan)
                            }
                            .fullScreenCover(isPresented: $showRideDetailView) {
                                DetailContentView(plan: $selectedPlan)
                            }
                            .fullScreenCover(isPresented: $showRunDetailView) {
                                DetailContentView(plan: $selectedPlan)
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .padding(.leading, 10)
    }
    
}

extension WeekView {
    private func setDetailView(session: String) {
        if session == Sessions.rideRun.rawValue {
            showBrickDetailView = true
            showSwimDetailView = false
            showRideDetailView = false
            showRunDetailView = false
        } else if session == Sessions.swim.rawValue {
            showBrickDetailView = false
            showSwimDetailView = true
            showRideDetailView = false
            showRunDetailView = false
        } else if session == Sessions.ride.rawValue {
            showBrickDetailView = false
            showSwimDetailView = false
            showRideDetailView = true
            showRunDetailView = false
        } else if session == Sessions.run.rawValue {
            showBrickDetailView = false
            showSwimDetailView = false
            showRideDetailView = false
            showRunDetailView = true
        } else {
            // All False
        }
      
    }
    
}




