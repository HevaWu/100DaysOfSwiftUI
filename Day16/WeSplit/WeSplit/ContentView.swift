//
//  ContentView.swift
//  WeSplit
//
//  Created by He Wu on 2021/08/29.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    
    var body: some View {
        Form {
            TextField("Enter Name", text: $name)
            
            // use name not $name, because only want to read at here
            Text("Name is \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
