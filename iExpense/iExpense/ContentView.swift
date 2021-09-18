//
//  ContentView.swift
//  iExpense
//
//  Created by He Wu on 2021/09/18.
//

import SwiftUI

struct User: Codable {
    var first: String
    var second: String
}

struct ContentView: View {
    @State private var user = User(first: "Alice", second: "Bob")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.setValue(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
