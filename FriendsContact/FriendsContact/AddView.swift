//
//  AddView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var image: Image? = nil
    @State private var name: String = ""
    
    @State private var inputImage: UIImage? = nil
    @State private var showImagePicker = false
    
    @State private var centerCoordinator = CLLocationCoordinate2D()
    @State private var selectedPlace: CodableMKPointAnnotation?
    @State private var showPlaceDetails = false
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 200, height: 200)
                
                Form {
                    HStack {
                        Text("Name")
                            .font(.headline)
                        
                        TextField("Please input your name", text: $name)
                    }
                }
                .frame(maxHeight: 100)
                
                ZStack {
                    MapView(
                        centerCoordinator: $centerCoordinator,
                        selectedPlace: $selectedPlace,
                        showPlaceDetails: $showPlaceDetails
                    )
                        .edgesIgnoringSafeArea(.all)
                    
                    CenterCircleView()
                    
                    VStack {
                        HStack {
                            Button(action: readLocation) {
                                Text("Read Current Location")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.blue)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .padding()

                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(Text("New Friend"))
            .navigationBarItems(trailing: Button(action: {
                saveFriend()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
            .onAppear(perform: {
                showImagePicker = true
                locationFetcher.run()
            })
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func readLocation() {
        guard let location = locationFetcher.lastKnownPlace else { return }
        print("[AddView] current location is \(location)")
        centerCoordinator = location
        
        let annotation = CodableMKPointAnnotation()
        annotation.title = "Current Location"
        annotation.subtitle = "\(location)"
        annotation.coordinate = location
        selectedPlace = annotation
    }
    
    func saveFriend() {
        do {
            let newId = UUID()
            let friend = Friend(context: moc)
            friend.id = newId
            friend.name = name
            
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8),
               let filePath = FileManager.default.getDocumentDirectory()?.appendingPathComponent("\(newId).jpeg") {
                try jpegData.write(to: filePath, options: [.atomic, .completeFileProtection])
            }
            
            if let selectedPlace = selectedPlace,
               let locationFilePath = FileManager.default.getDocumentDirectory()?.appendingPathComponent("location_\(newId)") {
                let locationData = try JSONEncoder().encode(selectedPlace)
                try locationData.write(to: locationFilePath, options: [.atomic, .completeFileProtection])
            }
            
            try moc.save()
        } catch {
            print("[AddView] Save Friend Failed.")
        }
    }
    
    func loadImage() {
        guard let input = inputImage else { return }
        image = Image(uiImage: input)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
