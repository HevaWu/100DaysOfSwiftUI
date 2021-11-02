//
//  DetailView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI
import CoreData
import MapKit

struct DetailView: View {
    var friend: Friend
    
    @State private var centerCoordinator = CLLocationCoordinate2D()
    @State private var selectedPlace: CodableMKPointAnnotation?
    @State private var showPlaceDetails = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .border(Color.blue)
                
                Image(uiImage: friend.profileImage)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 400, height: 400)
            
            Text(friend.wrappedName)
            
            ZStack {
                MapView(
                    centerCoordinator: $centerCoordinator,
                    selectedPlace: $selectedPlace,
                    showPlaceDetails: $showPlaceDetails
                )
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            centerCoordinator = friend.currentLocation.coordinate
            selectedPlace = friend.currentLocation
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let friend = Friend(context: moc)
        friend.id = UUID()
        friend.name = "Test Name"
        
        return NavigationView {
            DetailView(friend: friend)
        }
    }
}
