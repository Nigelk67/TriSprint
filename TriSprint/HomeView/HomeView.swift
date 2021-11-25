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
                Text("Total plans completed = \(proportionPlanComplete)%")
            }
            .onAppear {
                setPlans()
            }
        }
    }
}


extension HomeView {
    
    func setPlans() {
        totalPlans = homeVm.calculateTotalNumberOfPlans(plans: plans)
        totalSwims = homeVm.calculateTotalNumberOfSwims(swims: swims)
        totalRides = homeVm.calculateTotalNumberOfRides(rides: rides)
        totalRuns = homeVm.calculateTotalNumberOfRuns(runs: runs)
        proportionPlanComplete = homeVm.calculatePlansCompleted(plans: totalPlans, swims: totalSwims, rides: totalRides, runs: totalRuns)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
