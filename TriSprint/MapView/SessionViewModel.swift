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
    @Published var secs = 0
    @Published var timer: Timer?
    @Published var timeText: String = "00:00:00"
    @Published var distanceText: String = "0.00"
    @Published var paceText: String = "0.00"
    @Published var measure: String = "metric"
    @Published var isPaused: Bool = false
    @Published var isSaving: Bool = false
    @Published var showConfirmationPopup: Bool = false
    let userDefaults = UserDefaults.standard
    @State private var ride: Ride?
    @State private var run: Run?
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    
    func saveSession(session: String, measure: String) {
        showSpinner()
        
        let context = PersistenceController.shared.container.viewContext
        
        if session == Sessions.ride.rawValue {
            let newRide = Ride(context: context)
            if measure == "metric" {
                newRide.distance = locationManager.distance.value
            } else {
                newRide.distance = locationManager.distance.value * 1.609
            }
            newRide.duration = Int16(secs)
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

        } else if session == Sessions.run.rawValue {
            let newRun = Run(context: context)
            newRun.distance = locationManager.distance.value
            newRun.duration = Int16(secs)
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

    }
    
}
