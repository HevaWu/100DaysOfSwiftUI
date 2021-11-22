//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by He Wu on 2021/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello World")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(Color.red)

            }
            .background(.blue)
            
            Text("More")
                .background(.green)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
