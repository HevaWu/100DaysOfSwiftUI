//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by He Wu on 2021/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .offset(x: 100, y: 100)
            .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
