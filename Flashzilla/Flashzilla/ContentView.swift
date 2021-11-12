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
        VStack {
            Text("Hello World")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded({ _ in
                    print("VStack tapped")
                })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
