//
//  ContentView.swift
//  Flashzilla
//
//  Created by He Wu on 2021/11/12.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        Text("Hello, world!")
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
                RotationGesture()
                    .onChanged({ angle in
                        currentAmount = angle
                    })
                    .onEnded({ angle in
                        finalAmount += currentAmount
                        currentAmount = .degrees(0)
                    })
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
