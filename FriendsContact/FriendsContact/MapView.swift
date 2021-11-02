//
//  MapView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/02.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinator: CLLocationCoordinate2D
    @Binding var selectedPlace: CodableMKPointAnnotation?
    @Binding var showPlaceDetails: Bool
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinator = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "MapViewPlace"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let place = view.annotation as? CodableMKPointAnnotation else {
                return
            }
            parent.selectedPlace = place
            parent.showPlaceDetails = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if (uiView.annotations.first as? MKPointAnnotation) != selectedPlace,
           let selectedPlace = selectedPlace {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(selectedPlace)
            uiView.centerCoordinate = centerCoordinator
        }
    }
}

extension MKPointAnnotation {
    static var example: CodableMKPointAnnotation {
        let annotation = CodableMKPointAnnotation()
        annotation.title = "Dummy Location"
        annotation.subtitle = "London Home to the 2012 Summer Olymics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            centerCoordinator: .constant(MKPointAnnotation.example.coordinate),
            selectedPlace: .constant(.example),
            showPlaceDetails: .constant(false)
        )
    }
}
