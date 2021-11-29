//
//  ContentView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/11/29.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User?
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
