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

    @State private var showEditScreen = false
    
    @State private var isUnlocked = false
    
    @State private var showAlert = false
    @State private var showAuthenticationError = false {
        didSet {
            showAlert = showAlert || showAuthenticationError
        }
    }
    @State private var showPlaceDetails = false {
        didSet {
            showAlert = showAlert || showPlaceDetails
        }
    }
    
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
                        AddPlaceButtonView(
                            centerCoordinate: $centerCoordinate,
                            locations: $locations,
                            selectedPlace: $selectedPlace,
                            showEditScreen: $showEditScreen
                        )
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
        .alert(isPresented: $showAlert) {
            if showPlaceDetails {
                return Alert(
                    title: Text(selectedPlace?.title ?? "Unknown"),
                    message: Text(selectedPlace?.subtitle ?? "Missing place information"),
                    primaryButton: Alert.Button.default(Text("OK")),
                    secondaryButton: Alert.Button.default(Text("Edit")) {
                        showEditScreen = true
                    }
                )
            }
            
            if showAuthenticationError {
                return Alert(
                    title: Text("Authentication Error"),
                    message: Text("Unlock faceID failed."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            return Alert(title: Text("Unknown"), message: Text("Unknown"), dismissButton: .default(Text("OK")))
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
                        showAuthenticationError = true
                    }
                }
            }
        } else {
            showAuthenticationError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
