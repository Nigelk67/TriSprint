//
//  HomeView.swift
//  TriSprint
//
//  Created by Nigel Karan on 25.11.21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVm = HomeViewModel()
    @State private var totalPlans = 0.0
    @State private var totalSwims = 0.0
    @State private var totalRides = 0.0
    @State private var totalRuns = 0.0
    @State private var proportionPlanComplete = "Zero"
    @State private var bounce = false
    @State private var startProgressBars = false
 
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ride.timestamp, ascending: true)], animation: .default)
    private var rides: FetchedResults<Ride>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp, ascending: true)], animation: .default)
    private var runs: FetchedResults<Run>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Swim.timestamp, ascending: true)], animation: .default)
    private var swims: FetchedResults<Swim>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.day, ascending: true)], animation: .default)
    private var plans: FetchedResults<Plan>
    
    var body: some View {
        ZStack {
            TriBackground()
            VStack {
                completedSoFar
            }
            .onAppear {
                bounce = true
                homeVm.calculateTotals(plans: plans, swims: swims, rides: rides, runs: runs)
                
            }
        }
    }
}


extension HomeView {
    
    private var completedSoFar: some View {
        VStack {
            Text("Completed So Far")
                .foregroundColor(Color.mainText)
                .font(.system(size: 18, weight: .medium, design: .rounded))
            HStack {
                VStack {
                    Text("Total")
                        .foregroundColor(Color.mainText)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                    
                    if homeVm.proportionCompleted == 0.0 {
                       
                    } else {
                        pieChart
                    }
                        
                    
                    
                }.padding()
                
                progressStack
                
            }.padding()
        }
    }
    
    private var pieChart: some View {
        
        PieChartModel([(Color.accentButton.opacity(0.6), 100),(Color.accentButton.opacity(0.2),homeVm.proportionCompleted)])
            .frame(width: 100, height: 100, alignment: .center)
            .scaleEffect(bounce ? 1 : 0)
            .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3).delay(0.05))
        }
        
    
    
    private var progressStack: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Swim")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                
                ProgressBarView(currentProgress: homeVm.currentProgress, endProgress: homeVm.swimProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
            }
            VStack(alignment: .leading) {
                Text("Ride")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                ProgressBarView(currentProgress: homeVm.currentProgress, endProgress: homeVm.rideProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
            }
            VStack(alignment: .leading) {
                Text("Run")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                ProgressBarView(currentProgress: homeVm.currentProgress, endProgress: homeVm.runProgress, barColor: Color.accentButton, barOpacity: 0.1, progressBarColor: Color.accentButton, progressBarOpacity: 0.8)
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
