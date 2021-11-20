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
    @StateObject private var sessionVm = SessionViewModel()
    @Environment(\.presentationMode) private var presentationMode
    @State private var hasStarted: Bool = false
    @State private var shouldShowStopActions = false
//    @State private var ride: Ride?
//    @State private var run: Run?

    var body: some View {
        
        ZStack {
            BackgroundView(plan: $plan)
            
            VStack {
                
                TargetStack(plan: $plan)
            
                Map(coordinateRegion: $mapVm.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil)
                    .accentColor(Color.mainButton)
                
                trackingMeasures

                trackingButtons
                
            }
            .alert(isPresented: $sessionVm.showConfirmationPopup) {
                Alert(title: Text("SAVED!"), message: Text("This session has been saved"), dismissButton: .default(Text("OK"), action: {
                    print("Nige: back to Schedule")
                }))
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Day: \(plan.day ?? "")")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
            
            if sessionVm.isSaving {
                withAnimation {
                    LoadingView()
                }
            }
            
        }
        .onAppear {
            mapVm.checkIfLocationServicesIsEnabled()
        }
    }
    
    
    //MARK: Private Views
    private var trackingMeasures: some View {
        VStack {
            HStack {
                Text("Time:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.timeText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Distance:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.distanceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Speed:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(sessionVm.paceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
        }
        
    }
    
    private var trackingButtons: some View {
        HStack {
            Button {
                sessionVm.pauseSession()
            } label: {
                Text(sessionVm.isPaused ? "Continue" : "Pause")
                    .frame(width: 90, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(hasStarted ? Color.accentButton : Color.gray)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
                //.padding(.leading,30)
            }
            .disabled(hasStarted ? false : true)
            Spacer()
            
            Button {
                hasStarted = true
                start()
            } label: {
                Text("Start")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
            }.buttonStyle(StartButton(hasStarted: hasStarted))
                .disabled(hasStarted ? true : false)
                .opacity(hasStarted ? 0.5 : 1)
            Spacer()
            
            Button {
                shouldShowStopActions.toggle()
            } label: {
                Text("Stop")
                    .frame(width: 90, height: 40, alignment: .center)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .background(hasStarted ? Color.red : Color.gray)
                    .opacity(hasStarted ? 1 : 0.5)
                    .foregroundColor(Color.mainText)
                    .cornerRadius(5)
                    .disabled(hasStarted ? false : true)
                //.padding(.trailing,30)
            }
            .actionSheet(isPresented: $shouldShowStopActions) {
                .init(title: Text("\(self.plan.session ?? "") STOPPED!"),
                      message: Text("You can"),
                      buttons: [
                        .default(Text("Finish & Save This Session"), action: {
                            hasStarted = false
                            sessionVm.sesssionStopped()
                            sessionVm.saveSession(session: plan.session ?? "")
//                            self.performSegue(withIdentifier: "toRideDetailsVC", sender: nil)
                        }),
                        .destructive(Text("Discard This Session"),
                                     action: {
                                         hasStarted = false
                                         sessionVm.sesssionStopped()
                                     }),
                        .cancel(Text("Carry On!"))
                      ]
                )
            }
        }
        .frame(width: 350)
        .padding(.vertical, 30)
        
    }
    
    //MARK: Functions:
    private func start() {
        sessionVm.secs = 0
        mapVm.distance = Measurement(value: 0, unit: UnitLength.meters)
        mapVm.locationList.removeAll()
        sessionVm.updateDisplay()
        sessionVm.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            sessionVm.eachSecond()
        })
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
                    .font(.title3)
            } else {
                Text(plan.runTime ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
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
                    .font(.title3)
            } else {
                Text(plan.runRpe ?? "")
                    .foregroundColor(Color.mainText)
                    .font(.title3)
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
