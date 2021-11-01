//
//  ContentView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI
import CoreData

struct Friend: Identifiable {
    let id: UUID
    let image: UIImage
    let name: String
}

struct ContentView: View {
    @State private var friends = [Friend]()
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List(friends) { friend in
                HStack {
                    Image(uiImage: friend.image)
                        .clipShape(Circle())
                    
                    Text(friend.name)
                }
            }
            .navigationBarTitle(Text("Friends Contact"))
            .navigationBarItems(trailing: Button(action: {
                showAddView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showAddView, onDismiss: {
                // show dialog ask user save or not
            }, content: {
                // update to Edit View
                AddView()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
