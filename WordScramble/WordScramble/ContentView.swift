//
//  ContentView.swift
//  WordScramble
//
//  Created by He Wu on 2021/09/11.
//

import SwiftUI

struct ContentView: View {
    let people = ["Alice", "Bob", "Cindy", "Fare"]
    
    var body: some View {
        List(people, id: \.self) {
            Text("Hello, world! \($0)")
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
