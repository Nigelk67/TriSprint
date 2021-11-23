//
//  RidesView.swift
//  TriSprint
//
//  Created by Nigel Karan on 23.11.21.
//

import SwiftUI

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

struct RidesView_Previews: PreviewProvider {
    static var previews: some View {
        RidesView(ride: Ride())
    }
}
