//
//  LocationManager.swift
//  TriSprint
//
//  Created by Nigel Karan on 19.11.21.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var distance = Measurement(value: 0, unit: UnitLength.meters)
    @Published var locationList: [CLLocation] = []
    @Published var lineCoordinates: [CLLocationCoordinate2D] = []
    private let mapView = MKMapView()
    @ObservedObject var mapViewVm = MapViewModel()
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
        }
        
        for newLocation in locations {
          let howRecent = newLocation.timestamp.timeIntervalSinceNow
          guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
          if let lastLocation = locationList.last {
            let delta = newLocation.distance(from: lastLocation)
            distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            //let coordinates = [lastLocation.coordinate, newLocation.coordinate]
              lineCoordinates = [lastLocation.coordinate, newLocation.coordinate]
              mapView.addOverlay(MKPolyline(coordinates: lineCoordinates, count: 2))
              let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
              mapView.setRegion(region, animated: true)
          }
          locationList.append(newLocation)
        }
        
    }
   
}

extension LocationManager: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer(overlay: overlay) }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .green
        renderer.lineWidth = 3
        return renderer
    }
}
