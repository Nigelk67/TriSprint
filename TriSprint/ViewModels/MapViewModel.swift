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
    //@Published var region = MKCoordinateRegion()
    var locationManager: CLLocationManager?
    var ride: Ride?
    var run: Run?
    
    
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
    
    func startLocationUpdates() {
        if let locationManager = locationManager {
            locationManager.delegate = self
            locationManager.activityType = .fitness
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
//    let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
    

    
//    private func mapRegion() -> MKCoordinateRegion? {
//
//        guard let locations = ride?.locations,locations.count > 0 else { return nil }
//        let latitudes = locations.map { location -> Double in
//          let location = location as! Location
//          return location.latitude
//        }
//
//        let longitudes = locations.map { location -> Double in
//          let location = location as! Location
//          return location.longitude
//        }
//
//        let maxLat = latitudes.max()!
//        let minLat = latitudes.min()!
//        let maxLong = longitudes.max()!
//        let minLong = longitudes.min()!
//
//        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2)
//        let span = MapDetails.startingSpan
//
//        return MKCoordinateRegion(center: center, span: span)
//    }
    
}


