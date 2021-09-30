//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by He Wu on 2021/09/30.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(username.isEmpty || email.isEmpty || disableForm)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
