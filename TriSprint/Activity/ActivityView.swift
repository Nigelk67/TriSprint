//
//  ActivityView.swift
//  TriSprint
//
//  Created by Nigel Karan on 21.11.21.
//

import SwiftUI

struct ActivityView: View {
  
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
                        NoPlansView()
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
    let ride: Ride
//    init(ride: Ride) {
//        self.ride = ride
//        fetchRequest = FetchRequest<Ride>(entity: Ride.entity(), sortDescriptors: [.init(key: "timestamp", ascending: false)], predicate: .init(format: "ride == %@", self.ride))
//    }
//    var fetchRequest: FetchRequest<Ride>
    
    var body: some View {
        
        VStack {
            Text("\(ride.duration)")
        }
    }
    
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
