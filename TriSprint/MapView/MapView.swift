//
//  MapView.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import SwiftUI

struct MapView: View {
    
    @Binding var plan: Plan
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {

        ZStack {
            BackgroundView(plan: $plan)

            VStack {
                CancelButton(presentationMode: presentationMode)
                DayView(day: plan.day ?? "5")
                    .padding(.bottom, 30)

                //MAPVIEW HERE
                HStack {
                    Text("Target Time:")
                    Text(plan.rideTime ?? "")
                }
                HStack {
                    Text("Time:")
                    Text("20:33")
                }
                HStack {
                    Text("Distance:")
                    Text("2.3")
                }
                HStack {
                    Text("Speed:")
                    Text("10.45")
                }

                HStack {
                    Button {
                        print("Nige: Pause button pressed")
                    } label: {
                        Text("Pause")
                    }
                    Button {
                        print("Nige: Start button pressed")
                    } label: {
                        Text("Start")
                    }
                    Button {
                        print("Nige: Stop button pressed")
                    } label: {
                        Text("Stop")
                    }

                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(plan: .constant(Plan()))
    }
}
