//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello Word!")
                .font(.largeTitle)
            Text("Hello Word!")
                .blur(radius: 0)
            Text("Hello Word!")
            Text("Hello Word!")
        }
        .font(.title)
        .blur(radius: 5)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
