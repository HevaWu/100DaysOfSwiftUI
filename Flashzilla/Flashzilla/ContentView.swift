//
//  ContentView.swift
//  Flashzilla
//
//  Created by He Wu on 2021/11/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onTapGesture(count: 2) {
                print("Double tapped")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
