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
        ZStack {
            Image("bear")
            
            Rectangle()
                .fill(Color.blue)
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 400)
        .clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
