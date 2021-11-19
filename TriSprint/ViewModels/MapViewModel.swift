//
//  MapViewModel.swift
//  TriSprint
//
//  Created by Nigel Karan on 18.11.21.
//

import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.startingSpan)
    var locationManager: CLLocationManager?
    //*********
    @Published var location: CLLocation?
    @Published var distance = Measurement(value: 0, unit: UnitLength.meters)
    @Published var locationList: [CLLocation] = []
    @State private var mapView = MKMapView()
  //***********
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            
        } else {
            //******** SHOW ALERT NEED TO TURN ON LOCATION SERVICES **********
        }
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("ALERT")
            //******** SHOW ALERT LOCATION IS RESTRICTED PROBABLY DUE TO PARENTAL CONTROLS **********
        case .denied:
            print("ALERT")
            //******** SHOW ALERT LOCATION PERMISSIONS DENIED - CHANGE IN SETTINGS **********
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.startingSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    func stopLocationUpdates() {
        if let locationManager = locationManager {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func startLocationUpdates() {
        if let locationManager = locationManager {
            locationManager.delegate = self
            locationManager.activityType = .fitness
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }

    
}


