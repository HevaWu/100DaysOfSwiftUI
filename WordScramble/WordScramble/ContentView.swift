//
//  ContentView.swift
//  WordScramble
//
//  Created by He Wu on 2021/09/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                
                Text("Hello, world!")
            }
            
            Section(header: Text("Section 2")) {
                ForEach(0..<5) { _ in
                    Text("Hello, world!")
                }
            }
            
            Section(header: Text("Section 3")) {
                
                Text("Hello, world!")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
