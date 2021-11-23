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
                GeometryReader { fullView in
                ScrollView() {
                    if !rides.isEmpty {
                        LazyVStack {
                            Spacer()
                            ForEach(rides) { ride in
                                RidesView(ride: ride)
                                    .frame(width: fullView.size.width - 40, height: 200, alignment: .center)
                                    .padding(.bottom,20)
                                    .shadow(color: .gray, radius: 4, x: 5, y: 5)
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
}

struct RidesView: View {
    @ObservedObject var activityVm = ActivityViewModel()
    let ride: Ride
    
    var body: some View {
        
        VStack() {
            
            HStack {
                Spacer()
                Text("\(activityVm.rideDateText)")
                Spacer()
            }
            .background(Color.accentButton.opacity(0.3))
            
            VStack(alignment: .center) {
                HStack {
                    Image(activityVm.imageName)
                        .padding()
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Time: \(activityVm.rideTimeText)")
                        Text("Distance: \(activityVm.rideDistanceText)")
                        Text("Pace: \(activityVm.ridePaceText)")
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Color.accentButton)
            .cornerRadius(20)
        }
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
