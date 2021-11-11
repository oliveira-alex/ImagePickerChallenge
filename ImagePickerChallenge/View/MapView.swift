//
//  MapView.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 09/11/21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    //    typealias UIViewType = MKMapView
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = false
            
            return view
        }
        
        // Zoom in on the pin after loading the map
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            let zeroLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            let coordinateRegionClose = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 100_000, longitudinalMeters: 100_000)
            
            if parent.locationCoordinate != zeroLocation {
                mapView.setRegion(coordinateRegionClose, animated: true)
            }
        }
    }
    
    let locationCoordinate: CLLocationCoordinate2D
    var pointAnnotation: MKPointAnnotation {
        let point = MKPointAnnotation()
        point.coordinate = locationCoordinate
        
        return point
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let zeroLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)

        if locationCoordinate != zeroLocation {
            let coordinateRegionFar = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500_000, longitudinalMeters: 500_000)
            
            uiView.setRegion(coordinateRegionFar, animated: true)
            uiView.addAnnotation(pointAnnotation)
        }
    }
    
    
    
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        if lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude {
            return true
        }
        return false
    }
    
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
