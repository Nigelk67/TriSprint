//
//  SessionViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 20.11.21.
//

import SwiftUI

class SessionViewModel: ObservableObject {
    
    @StateObject private var mapVm = MapViewModel()
    @ObservedObject private var locationManager = LocationManager()
    @Published var secs: Double = 0
    @Published var timer: Timer?
    @Published var timeText: String = "00:00:00"
    @Published var distanceText: String = "0.00"
    @Published var paceText: String = "0.00"
    @Published var measure: String = CustomUserDefaults.shared.get(key: .measure) as? String ?? ""
    @Published var isPaused: Bool = false
    @Published var isSaving: Bool = false
    @Published var showConfirmationPopup: Bool = false
    @Published var showRatingsView = false
    @Published var timeAtBackground: Date = Date()
    let userDefaults = UserDefaults.standard
    @State private var ride: Ride?
    @State private var run: Run?
    @State private var swim: Swim?
    
    func sesssionStopped() {
        locationManager.stopLocationUpdates()
        resetLabels()
        timer?.invalidate()
    }
    
    func eachSecond() {
        secs += 1
        updateDisplay()
    }
    
    func updateDisplay() {
        if self.measure == "Kilometers" {
            let formattedDistance = FormatDisplay.distanceInKm(locationManager.distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pacePerKm(distance: locationManager.distance, seconds: secs, outputUnit: UnitSpeed.minutesPerKilometer)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        } else {
            let formattedDistance = FormatDisplay.distance(locationManager.distance)
            let formattedTime = FormatDisplay.time(secs)
            let formattedPace = FormatDisplay.pacePerMile(distance: locationManager.distance, seconds: secs, outputUnit: UnitSpeed.minutesPerMile)
            distanceText = "\(formattedDistance)"
            timeText = "\(formattedTime)"
            paceText = "\(formattedPace)"
        }
    }
    
    func refreshDisplay() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            self.eachSecond()
        })
    }
    
    func pauseSession() {
        if isPaused == false {
            isPaused = true
            timer?.invalidate()
            userDefaults.set(secs, forKey: "pausedSeconds")
        } else if isPaused == true {
            isPaused = false
            refreshDisplay()
        }
    }
    
    func resetLabels() {
        timeText = "00:00:00"
        distanceText = "0.00"
        paceText = "0.00"
    }
    
    func showSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            self.showConfirmationPopup = true
        }
    }
    
    func markPlanComplete(plan: Plan) {
        let context = PersistenceController.shared.container.viewContext
        plan.completed = 1
        do {
            try context.save()
        } catch {
            print("Error saving plan completed", error)
        }
    }
    
    private func saveRideToCoreData(distance: Double, secs: Double) {
        let context = PersistenceController.shared.container.viewContext
        let newRide = Ride(context: context)
        newRide.distance = distance
        newRide.duration = secs
        newRide.timestamp = Date()
        do {
            try context.save()
        } catch {
            print("Error saving ride to CoreData", error)
        }
        ride = newRide
    }
    
    private func saveRunToCoreData(distance: Double, secs: Double) {
        let context = PersistenceController.shared.container.viewContext
        let newRun = Run(context: context)
        newRun.distance = distance
        newRun.duration = secs
        newRun.timestamp = Date()
        do {
            try context.save()
        } catch {
            print("Error saving ride to CoreData", error)
        }
        run = newRun
    }
    
    private func saveSwimToCoreData(distance: Double, secs: Double) {
        let context = PersistenceController.shared.container.viewContext
        let newSwim = Swim(context: context)
        newSwim.distance = distance
        newSwim.duration = secs
        newSwim.timestamp = Date()
        do {
            try context.save()
        } catch {
            print("Error saving ride to CoreData", error)
        }
        swim = newSwim
    }
    
    func saveManualSession(session: String, measure: String, distance: String, duration: String) {
        
        showSpinner()
        
        guard let distanceDbl = Double(distance) else { return }
        let distanceInMtrs: Double

        if measure == Measure.kilometers.rawValue {
            distanceInMtrs = distanceDbl * 1000
        } else {
            distanceInMtrs = (distanceDbl * 1609)
        }
        guard let durationDbl = Double(duration) else { return }
       
        let secs = durationDbl * 60
       
        if session == Sessions.ride.rawValue {
            saveRideToCoreData(distance: distanceInMtrs, secs: secs)
        } else if session == Sessions.run.rawValue {
            saveRunToCoreData(distance: distanceInMtrs, secs: secs)
        } else if session == Sessions.swim.rawValue {
            saveSwimToCoreData(distance: distanceInMtrs, secs: secs)
        }
    }
    
    private func saveRideWithLocationsToCoreData() {
        let context = PersistenceController.shared.container.viewContext
        let newRide = Ride(context: context)
        newRide.distance = locationManager.distance.value
        newRide.duration = secs
        newRide.timestamp = Date()
        for location in locationManager.locationList {
            let locationObject = Location(context: context)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRide.addToLocations(locationObject)
        }
        do {
            try context.save()
        } catch {
            print("Error saving ride to CoreData", error)
        }
        ride = newRide
    }
    
    private func saveRunWithLocationsToCoreData() {
        let context = PersistenceController.shared.container.viewContext
        let newRun = Run(context: context)
        newRun.distance = locationManager.distance.value
        newRun.duration = secs
        newRun.timestamp = Date()
        for location in locationManager.locationList {
            let locationObject = Location(context: context)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRun.addToLocations(locationObject)
        }
        do {
            try context.save()
        } catch {
            print("Error saving run to CoreData", error)
        }
        run = newRun
    }
    
    func saveSession(session: String, measure: String) {
        
        showSpinner()
       
        if session == Sessions.ride.rawValue {
            saveRideWithLocationsToCoreData()

        } else if session == Sessions.run.rawValue {
            saveRunWithLocationsToCoreData()
        }

    }
    
}
