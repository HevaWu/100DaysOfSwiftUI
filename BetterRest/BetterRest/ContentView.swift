//
//  ContentView.swift
//  BetterRest
//
//  Created by He Wu on 2021/09/08.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now...tomorrow
        
        DatePicker("Please enter a date", selection: $wakeUp, in: range, displayedComponents: .hourAndMinute)
            .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
