//
//  MapView.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var plan: Plan
    @StateObject private var mapVm = MapViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var timeText: String = "00:00:00"
    @State private var distanceText: String = "0"
    @State private var paceText: String = "0"
    @State private var measure: String = "metric"
    @State private var distance = Measurement(value: 0, unit: UnitLength.meters)
    @State private var secs = 0
    @State private var timer: Timer?
    
    var body: some View {
        
        ZStack {
            BackgroundView(plan: $plan)
            
            VStack {

                TargetStack(plan: $plan)
                
                Map(coordinateRegion: $mapVm.region, showsUserLocation: true)
                    .accentColor(Color.mainButton)
           
                HStack {
                    Text("Time:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text(timeText)
                        .foregroundColor(Color.mainText)
                        .font(Font.monospacedDigit(.title)())
                }
                HStack {
                    Text("Distance:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text(distanceText)
                        .foregroundColor(Color.mainText)
                        .font(Font.monospacedDigit(.title)())
                }
                HStack {
                    Text("Speed:")
                        .font(.title3)
                        .foregroundColor(Color.mainText)
                    Text("10.45")
                        .foregroundColor(Color.mainText)
                        .font(.title)
                }
                
                trackingButtons
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Day: \(plan.day ?? "")")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
            .onAppear {
                mapVm.checkIfLocationServicesIsEnabled()
            }
        }
    }
    
    
    private func eachSecond() {
        secs += 1
        updateDisplay()
    }
    private func updateDisplay() {
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.distanceInKm(distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pace(distance: distance, seconds: secs, outputUnit: UnitSpeed.minutesPerKilometer)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        } else {
            let formattedDistance = FormatDisplay.distance(distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pace(distance: distance, seconds: secs, outputUnit: UnitSpeed.minutesPerMile)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        }
        
    }
    private var trackingButtons: some View {
        //var body: some View {
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
                    updateDisplay()
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                        self.eachSecond()
                    })
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(plan: .constant(Plan()))
    }
}
