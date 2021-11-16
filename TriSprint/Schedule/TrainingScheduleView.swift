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
    @State private var showDetailView = false
    
    
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
                            Spacer()
                            NoPlansView()
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
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
