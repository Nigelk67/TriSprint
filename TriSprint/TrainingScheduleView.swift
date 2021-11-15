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
                    Spacer()
                    ScrollView() {
                        if !plans.isEmpty {
                            LazyVStack {
                                ForEach(weeks, id: \.self) { week in
                                    Section(header: SectionHeaderView(week: Int16(week))) {
                                        ForEach(plans) { plan in
                                            if plan.week == week {
                                                
                                                HStack {
                                                    Text(plan.day ?? "")
                                                    Text(plan.session ?? "No Sess")
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                
                            }
                        } else {
                            Text("No Plans")
                        }
                    }
                }.navigationTitle("Training Schedule")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

struct ScheduleOverview: View {
    var image: String
    var day: String
    var body: some View {
        VStack {
            Text(day)
                .font(.title3)
            Image(image)
                .padding(.vertical)
                .opacity(0.8)
        }
        .padding(.horizontal,4)
    }
}

struct SectionHeaderView: View {
    var week: Int16
    var body: some View {
        HStack {
            Text("Week\(week)")
                .font(.title2)
                .foregroundColor(Color.mainBackground)
            Spacer()
        }
    }
}
struct TrainingPlanView: View {
    
    let plan: Plan
    
    //Add this so the UI refreshes a plan after editing:
    @State var refreshId = UUID()
    //*************************************************
    
    var body: some View {
        
        ScrollView {
            HStack {
                Text("\(plan.week)")
                    .foregroundColor(Color.mainText)
                    .padding()
                    .font(.system(.title2, design: .rounded))
                Spacer()
            }.padding(.horizontal)
                .background(Color.accentButton.opacity(0.2))
            
            ScrollView(.horizontal) {
                HStack {
                    let imageName = setImageNames(session: plan.session ?? "")
                    ScheduleOverview(image: imageName, day: plan.day ?? "")
                }.padding(.horizontal)
            }
        }
        
    }
    private func setImageNames(session: String) -> String {
        var imageName = ""
        let sess = Sessions(rawValue: session)
        switch sess {
        case .swim:
            imageName = TrainingImageNames.trainingSwim.rawValue
        case .ride:
            imageName = TrainingImageNames.trainingRide.rawValue
        case .run:
            imageName = TrainingImageNames.trainingRun.rawValue
        case .brick:
            imageName = TrainingImageNames.brickBikeRun.rawValue
        case .none:
            imageName = ""
        }
        return imageName
    }
}

struct TrainingScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        TrainingScheduleView().environment(\.managedObjectContext, viewContext)
    }
}
