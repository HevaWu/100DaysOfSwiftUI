//
//  ContentView.swift
//  iExpense
//
//  Created by He Wu on 2021/09/18.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Alice"
    @Published var lastName = "Bob"
}

struct ContentView: View {
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
            Text("Name is: \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
