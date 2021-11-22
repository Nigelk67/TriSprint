//
//  ActivityView.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

struct ActivityView: View {
  
    @ObservedObject var activityVm = ActivityViewModel()
    
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
    
    var body: some View {
        
        ZStack {
            SwimBackground()
            VStack {
                ScrollView() {
                    if !rides.isEmpty {
                        
                        LazyVStack {
                            Spacer()
                            ForEach(rides) { ride in
                                RidesView(ride: ride)
                            }
                        }
                    } else {
                        Spacer()
                        VStack {
                            Text("No Activity yet")
                        }
                    }
                }
            }
            .navigationTitle("Training Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
        }
    }
}

struct RidesView: View {
    @ObservedObject var activityVm = ActivityViewModel()
    let ride: Ride
//    init(ride: Ride) {
//        self.ride = ride
//        fetchRequest = FetchRequest<Ride>(entity: Ride.entity(), sortDescriptors: [.init(key: "timestamp", ascending: false)], predicate: .init(format: "ride == %@", self.ride))
//    }
//    var fetchRequest: FetchRequest<Ride>
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("\(activityVm.dateText)")
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                Image(activityVm.imageName)
                    .padding(.leading, 15)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Time: \(activityVm.timeText)")
                    Text("Distance: \(activityVm.distanceText)")
                    Text("Pace: \(activityVm.paceText)")
                }
                .padding(.leading, 15)
            }
        }
        .frame(width: 350, height: 200, alignment: .leading)
        .background(Color.white.opacity(0.9)
                        .shadow(color: .blue, radius: 15, x: 10, y: 0))
        .cornerRadius(20)
        
        
        
        
        .onAppear {
            activityVm.updateRides(ride: ride)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
