//
//  HomeNavView.swift
//  TriSprint
//
//  Created by Nigel Karan on 12.11.21.
//

import SwiftUI

struct HomeNavView: View {
    @State private var nextScreen = false
    @State private var toLogin = false
    //@ObservedObject var trainingVm = TrainingPlanArrayViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.week, ascending: true)], animation: .default)
    private var plans: FetchedResults<Plan>
    
    var body: some View {
        
        VStack {
            Spacer()
            Button {
                toLogin.toggle()
            } label: {
                Text("Login Screen")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
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
                .fullScreenCover(isPresented: $toLogin) {
                    LoginView()
                }
        }
    }
}

struct HomeNavView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavView()
    }
}
