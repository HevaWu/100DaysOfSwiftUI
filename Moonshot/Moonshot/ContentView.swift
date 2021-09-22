//
//  ContentView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Decoded JSON") {
            let input = """
                {
                    "name": "some name",
                    "address": {
                        "street": "test street",
                        "city": "test city"
                    }
                }
                """
            
            struct User: Codable {
                var name: String
                var address: Address
            }
            
            struct Address: Codable {
                var street: String
                var city: String
            }
            
            if let decoded = try? JSONDecoder().decode(User.self, from: Data(input.utf8)) {
                print("\(decoded.name), \(decoded.address.street), \(decoded.address.city)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
