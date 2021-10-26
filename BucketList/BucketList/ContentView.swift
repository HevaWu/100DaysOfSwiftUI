//
//  ContentView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/19.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showPlaceDetails = false
    
    @State private var showEditScreen = false
    
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                
                MapView(
                    centerCoordinator: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showPlaceDetails: $showPlaceDetails,
                    annotations: locations
                )
                    .edgesIgnoringSafeArea(.all)
                
                CenterCircleView()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example location"
                            newLocation.coordinate = centerCoordinate
                            locations.append(newLocation)
                            
                            selectedPlace = newLocation
                            showEditScreen = true
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
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
        .sheet(isPresented: $showEditScreen, onDismiss: saveData) {
            if let selectedPlace = selectedPlace {
                EditView(placemark: selectedPlace)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentDiretory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentDiretory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        let filename = getDocumentDiretory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        // error handling
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
