//
//  MapKitView.swift
//  TriSprint
//
//  Created by Nigel Karan on 14.12.21.
//

import SwiftUI
import MapKit


struct MapKitView: UIViewRepresentable {
    //@Binding var region: MKCoordinateRegion
    //@Binding var lineCoordinates: [CLLocationCoordinate2D]
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var mapVm = MapViewModel()
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = mapVm.region
        let polyline = MKPolyline(coordinates: locationManager.lineCoordinates, count: 2)
        mapView.addOverlay(polyline)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
}
class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapKitView
    
    init(_ parent: MapKitView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
