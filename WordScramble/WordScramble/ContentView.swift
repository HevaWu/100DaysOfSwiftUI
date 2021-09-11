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
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: <#T##String?#>) {
            if let fileContent = try? String(contentsOf: fileURL) {
                // ... do something
            }
        }
        
        return Text("Hello, world! ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
