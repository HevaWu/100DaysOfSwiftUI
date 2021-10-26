//
//  AddPlaceButtonView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/26.
//

import SwiftUI
import MapKit

struct AddPlaceButtonView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showEditScreen: Bool
    
    var body: some View {
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

struct AddPlaceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceButtonView(
            centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            locations: .constant([]),
            selectedPlace: .constant(MKPointAnnotation.example),
            showEditScreen: .constant(false))
    }
}
