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
    @State private var showDetailView = false
    @ObservedObject var scheduleVm = ScheduleViewModel()
    @State private var selectedPlan = Plan(entity: Plan.entity(), insertInto: nil)
    
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
                                showDetailView.toggle()
                            } label: {
                                let imageName = scheduleVm.setImageNames(session: plan.session ?? "", completed: plan.completed)
                                Image(imageName)
                            }
                            .fullScreenCover(isPresented: $showDetailView) {
                                TrainingDetailView(plan: $selectedPlan)
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .padding(.leading, 10)
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(plans) { plan in
//                    if plan.week == week {
//                        VStack {
//                            HStack {
//                                Text("Day")
//                                Text(plan.day ?? "")
//                            }
//                            .foregroundColor(Color.mainText)
//                            .font(.subheadline)
//
//                            Button {
//                                selectedPlan = plan
//                                showDetailView.toggle()
//                            } label: {
//                                //Text("HERE")
//                                //                                let imageName = scheduleVm.setImageNames(session: plan.session ?? "", completed: plan.completed)
//                                //                                Image(imageName)
//                                //                                    .opacity(0.8)
//                            }
//                            .fullScreenCover(isPresented: $showDetailView) {
//                                TrainingDetailView(plan: $selectedPlan)
//                            }
//                        }
//                        .padding(.horizontal,5)
//                        .padding(.bottom,30)
//
//                    }
//                    // else {}
//                }
//            }
//        }
//        .padding(.leading,10)
    }
}





//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView(plans: , week: )
//    }
//}
