//
//  ContentView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Friend.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Friend.name, ascending: true)]
    ) var friends: FetchedResults<Friend>
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List(friends) { friend in
                NavigationLink {
                    DetailView(friend: friend)
                } label: {
                    HStack {
                        Image(uiImage: friend.profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                            .clipShape(Circle())
                        
                        Text(friend.wrappedName)
                    }
                    .frame(maxHeight: 50)
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
                AddView().environment(\.managedObjectContext, moc)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
