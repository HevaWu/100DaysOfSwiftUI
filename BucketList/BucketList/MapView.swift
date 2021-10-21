//
//  MapView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinator: CLLocationCoordinate2D
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        return mapView
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olymics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinator: .constant(MKPointAnnotation.example.coordinate))
    }
}
