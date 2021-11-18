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
                DayView(day: plan.day ?? "5")
                    .padding(.bottom, 30)
                
                //MAPVIEW HERE
                
                TargetStack(plan: $plan)
                
                HStack {
                    Text("Time:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text("20:33")
                        .foregroundColor(Color.mainText)
                        .font(.title)
                }
                HStack {
                    Text("Distance:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text("2.3")
                        .foregroundColor(Color.mainText)
                        .font(.title)
                }
                HStack {
                    Text("Speed:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text("10.45")
                        .foregroundColor(Color.mainText)
                        .font(.title)
                }
                
                TrackingButtons()
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
        }
    }
    
   
}

struct TargetStack: View {
    
    @Binding var plan: Plan
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Target Time:")
                .font(.system(size: 16))
                .foregroundColor(Color.mainText)
            if plan.session == Sessions.ride.rawValue {
                Text(plan.rideTime ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title)
            } else {
                Text(plan.runTime ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title)
            }
            Text("mins")
                .foregroundColor(Color.mainText)
                .font(.system(size: 12))
                .padding(.leading,-4)
        //}
        Spacer()
       // HStack(alignment: .firstTextBaseline) {
            Text("Target RPE:")
                .font(.system(size: 16))
                .foregroundColor(Color.mainText)
            if plan.session == Sessions.ride.rawValue {
                Text(plan.rideRpe ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title)
            } else {
                Text(plan.runRpe ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title)
            }
        }
        .frame(width: 350, height: 50, alignment: .center)
        
    }
}

struct TrackingButtons: View {
    var body: some View {
        HStack {
            Button {
                print("Nige: Pause button pressed")
            } label: {
                Text("Pause")
                    .frame(width: 80, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(Color.gray)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
                    //.padding(.leading,30)
            }
            Spacer()
            Button {
                print("Nige: Start button pressed")
            } label: {
                Text("Start")
                    .frame(width: 80, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(Color.accentButton)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
            }
            Spacer()
            Button {
                print("Nige: Stop button pressed")
            } label: {
                Text("Stop")
                    .frame(width: 80, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(Color.red)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
                    //.padding(.trailing,30)
            }
            
        }
        .frame(width: 350)
        .padding(.vertical, 30)
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(plan: .constant(Plan()))
    }
}
