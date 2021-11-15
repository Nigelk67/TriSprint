//
//  TrainingScheduleView.swift
//  TriSprint
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI

struct TrainingScheduleView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.week, ascending: true)], animation: .default)
    private var plans: FetchedResults<Plan>
    let weeks = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                SwimBackground()
                VStack {
                    ScrollView() {
                        if !plans.isEmpty {
                            LazyVStack {
                                Spacer()
                                ForEach(weeks, id: \.self) { week in
                                    Section(header: SectionHeaderView(week: Int16(week))) {
                                        WeekView(plans: plans, week: week)
                                    }
                                }
                            }
                        } else {
                            Text("No Plans")
                        }
                    }
                }
                .navigationBarHidden(true)
                //.navigationTitle("")
//                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct WeekView: View {
    
    var plans: FetchedResults<Plan>
    var week: Int
    @ObservedObject var scheduleVm = ScheduleViewModel()
    
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
                            print("Nige: image button pressed")
                        } label: {
                            let imageName = scheduleVm.setImageNames(session: plan.session ?? "")
                            Image(imageName)
                                .opacity(0.8)
                        }
                    }
                    .padding(.horizontal,5)
                    .padding(.bottom,30)
                    
                }
            }
            }
        }
        .padding(.leading,10)
    }
}

struct SectionHeaderView: View {
    var week: Int16
    var body: some View {
        HStack {
            Spacer()
            Text("Week \(week)")
                .font(.body)
                .foregroundColor(Color.mainText)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.vertical,4)
        .background(Color.accentButton.opacity(0.3))
    }
}


struct TrainingScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        TrainingScheduleView().environment(\.managedObjectContext, viewContext)
    }
}
