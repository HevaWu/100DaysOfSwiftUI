//
//  ContentView.swift
//  Animations
//
//  Created by He Wu on 2021/09/14.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: Double = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(
                Animation.interpolatingSpring(stiffness: 5, damping: 1)
            ) {
                self.animationAmount = 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 0.0, z: 1.0)
//            anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
//            anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
//            perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
