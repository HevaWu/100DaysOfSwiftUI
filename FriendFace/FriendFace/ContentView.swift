//
//  ContentView.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DownloadedUser.entity(), sortDescriptors: []) var downloadedUsers: FetchedResults<DownloadedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \User.id) { user in
                NavigationLink {
                    UserDetailView(user: user, allUsers: users)
                } label: {
                    Text(user.name)
                }
            }
            .onAppear(perform: loadUsers)
            .navigationBarTitle(Text("User List"))
            .navigationBarItems(
                leading: Button("Clear All Data", action: {
                    clearAllData()
                }),
                trailing: Button("Load User from web", action: {
                    loadUserFromWeb()
                })
            )
        }
    }
    
    func clearAllData() {
        PersistenceController.shared.container.performBackgroundTask { moc in
            do {
                for user in downloadedUsers {
                    for tag in user.wrappedTags {
                        if !tag.isDeleted {
                            moc.delete(tag)
                        }
                    }
                    
                    for friend in user.wrappedFriends {
                        if !friend.isDeleted {
                            moc.delete(friend)
                        }
                    }
                    moc.delete(user)
                }
                
                try moc.save()
                
                loadUserFromDataStore()
            } catch {
                print("[ContentView] remove user failed. \(error.localizedDescription)")
            }
        }
    }
    
    func loadUsers() {
        if !downloadedUsers.isEmpty {
            loadUserFromDataStore()
            return
        }
        
        loadUserFromWeb()
    }
    
    func loadUserFromDataStore() {
        users = downloadedUsers
            .map { $0.convertToUser() }
        print("[ContentView] load from dataStore.")
    }
    
    func loadUserFromWeb() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("[ContentView] load users failed: invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let decoded = try? JSONDecoder().decode([User].self, from: data) {
                saveToDataStore(decoded)
                users = decoded
                print("[ContentView] load from web")
            } else {
                print("[ContentView] load users failed: response error \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        .resume()
    }
    
    func saveToDataStore(_ decodedUsers: [User]) {
        PersistenceController.shared.container.performBackgroundTask { moc in
            moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            do {
                for user in decodedUsers {
                    let newUser = DownloadedUser(context: moc)
                    newUser.id = user.id
                    newUser.isActive = user.isActive
                    newUser.name = user.name
                    newUser.age = Int16(user.age)
                    newUser.company = user.company
                    newUser.email = user.email
                    newUser.address = user.address
                    newUser.about = user.about
                    newUser.registered = user.registered
                    
                    for tag in user.tags {
                        let newTag = DownloadedTag(context: moc)
                        newTag.name = tag
                        newUser.addToTags(newTag)
                    }
                    
                    for friend in user.friends {
                        let newFriend = DownloadedFriend(context: moc)
                        newFriend.id = friend.id
                        newFriend.name = friend.name
                        newUser.addToFriends(newFriend)
                    }
                    
                    try moc.save()
                }
            } catch {
                print("[ContentView] Save data error. \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
