//
//  ContentView.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
        }
    }
    
    func loadUsers() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("[ContentView] load users failed: invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let decoded = try? JSONDecoder().decode([User].self, from: data) {
                users = decoded
            } else {
                print("[ContentView] load users failed: response error \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        .resume()
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
