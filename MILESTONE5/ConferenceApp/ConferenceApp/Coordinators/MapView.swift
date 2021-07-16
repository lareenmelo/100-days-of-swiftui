//
//  MapView.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/16/21.
//

// Day 78
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var annotation: MKPointAnnotation?

    func makeUIView(context: Self.Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let annotation = annotation {
            mapView.setCenter(annotation.coordinate, animated: false)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Self.Context) {
        if let annotation = annotation {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Self.Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Location"

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                // no pop up
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
    }
}
