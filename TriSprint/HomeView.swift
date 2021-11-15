//
//  HomeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct HomeView: View {
    @State private var nextScreen = false
    //@ObservedObject var trainingVm = TrainingPlanArrayViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.day, ascending: true)], animation: .default)
    private var plans: FetchedResults<Plan>
    
    var body: some View {
        
        VStack {
            Spacer()
            Button {
                nextScreen.toggle()
            } label: {
                Text("Next Screen")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            Spacer()
            
            Button {
                plans.forEach { plan in
                    viewContext.delete(plan)
                }
                do {
                    try viewContext.save()
                } catch {
                    print("Failed to delete all plans", error)
                }
            } label: {
                Text("Delete All Plans")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            Spacer()
                .fullScreenCover(isPresented: $nextScreen) {
                    FirstTriathlonView()
                }
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
