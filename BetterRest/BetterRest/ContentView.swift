//
//  ContentView.swift
//  BetterRest
//
//  Created by He Wu on 2021/09/08.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
