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
//    @State private var locationList: [CLLocation] = []
    @State private var timeText: String = "00:00:00"
    @State private var distanceText: String = "0.00"
    @State private var paceText: String = "0.00"
    @State private var measure: String = "metric"
//    @State private var distance = Measurement(value: 0, unit: UnitLength.meters)
    @State private var secs = 0
    @State private var timer: Timer?
    @State private var isPaused: Bool = false
    @State private var hasStarted: Bool = false
    @State private var isSaving: Bool = false
    @State private var showConfirmationPopup: Bool = false
    let userDefaults = UserDefaults.standard
    @ObservedObject private var locationManager = LocationManager()
    @State private var shouldShowStopActions = false
    @State private var ride: Ride?
    @State private var run: Run?
//    let mapView = MKMapView()
    
//    @State private var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.startingSpan)
//    @ObservedObject private var locationManager = LocationManager()
//    @State private var cancellable: AnyCancellable?
//    private func setCurrentLocation() {
//        cancellable = locationManager.$location.sink { location in
//            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MapDetails.startingSpan)
//        }
//    }
    
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
            .alert(isPresented: $showConfirmationPopup) {
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
            
            if isSaving {
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
                Text(timeText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Distance:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(distanceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
            HStack {
                Text("Speed:")
                    .font(.body)
                    .foregroundColor(Color.mainText)
                Text(paceText)
                    .foregroundColor(Color.mainButton)
                    .font(Font.monospacedDigit(.title3)())
            }
        }
        
    }
    
    private var trackingButtons: some View {
        HStack {
            Button {
                pauseSession()
            } label: {
                Text(isPaused ? "Continue" : "Pause")
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
                            sesssionStopped()
                            saveSession(session: plan.session ?? "")
//                            self.saveRide()
//                            self.performSegue(withIdentifier: "toRideDetailsVC", sender: nil)
                        }),
                        .destructive(Text("Discard This Session"),
                                     action: {
                                         sesssionStopped()
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
        secs = 0
        mapVm.distance = Measurement(value: 0, unit: UnitLength.meters)
        mapVm.locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            self.eachSecond()
        })
        
    }
    
    private func eachSecond() {
        secs += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        if self.measure == "metric" {
            let formattedDistance = FormatDisplay.distanceInKm(locationManager.distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pace(distance: locationManager.distance, seconds: secs, outputUnit: UnitSpeed.minutesPerKilometer)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        } else {
            let formattedDistance = FormatDisplay.distance(locationManager.distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pace(distance: locationManager.distance, seconds: secs, outputUnit: UnitSpeed.minutesPerMile)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        }
    }
    
    private func refreshDisplay() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            self.eachSecond()
        })
    }
    
    private func pauseSession() {
        if isPaused == false {
            isPaused = true
            timer?.invalidate()
            userDefaults.set(secs, forKey: "pausedSeconds")
        } else if isPaused == true {
            isPaused = false
            refreshDisplay()
        }
    }
    
    private func sesssionStopped() {
        hasStarted = false
        locationManager.stopLocationUpdates()
        resetLabels()
        timer?.invalidate()
    }
    
    private func saveSession(session: String) {
        showSpinner()
//        let context = PersistenceController.shared.container.viewContext
//        if session == Sessions.ride.rawValue {
//            let newRide = Ride(context: context)
//            newRide.distance = locationManager.distance.value
//            newRide.duration = Int16(secs)
//            newRide.timestamp = Date()
//            for location in locationManager.locationList {
//                let locationObject = Location(context: context)
//                locationObject.timestamp = location.timestamp
//                locationObject.latitude = location.coordinate.latitude
//                locationObject.longitude = location.coordinate.longitude
//                newRide.addToLocations(locationObject)
//            }
//            do {
//                try context.save()
//            } catch {
//                print("Error saving ride to CoreData", error)
//            }
//            ride = newRide
//
//        } else if session == Sessions.run.rawValue {
//            let newRun = Run(context: context)
//            newRun.distance = locationManager.distance.value
//            newRun.duration = Int16(secs)
//            newRun.timestamp = Date()
//            for location in locationManager.locationList {
//                let locationObject = Location(context: context)
//                locationObject.timestamp = location.timestamp
//                locationObject.latitude = location.coordinate.latitude
//                locationObject.longitude = location.coordinate.longitude
//                newRun.addToLocations(locationObject)
//            }
//            do {
//                try context.save()
//            } catch {
//                print("Error saving run to CoreData", error)
//            }
//            run = newRun
//        }
        
    }
   
    private func resetLabels() {
        timeText = "00:00:00"
        distanceText = "0.00"
        paceText = "0.00"
    }
    
    private func showSpinner() {
        isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSaving = false
            showConfirmationPopup = true
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
