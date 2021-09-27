//
//  ContentView.swift
//  Drawing
//
//  Created by He Wu on 2021/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        Image("bear")
            .colorMultiply(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
