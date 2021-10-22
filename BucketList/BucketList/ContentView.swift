//
//  ContentView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/19.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showPlaceDetails = false
    
    @State private var showEditScreen = false
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinator: $centerCoordinate,
                selectedPlace: $selectedPlace,
                showPlaceDetails: $showPlaceDetails,
                annotations: locations
            )
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        let newLocation = MKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = centerCoordinate
                        locations.append(newLocation)
                        
                        selectedPlace = newLocation
                        showEditScreen = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showPlaceDetails) {
            Alert(
                title: Text(selectedPlace?.title ?? "Unknown"),
                message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                primaryButton: Alert.Button.default(Text("OK")),
                secondaryButton: Alert.Button.default(Text("Edit")) {
                    showEditScreen = true
                }
            )
        }
        .sheet(isPresented: $showEditScreen) {
            if let selectedPlace = selectedPlace {
                EditView(placemark: selectedPlace)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
