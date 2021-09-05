//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct ContentView: View {
    var text1: some View {
        Text("Hello Word!")
    }
    let text2 = Text("Hello Word Hello!")
    
    var body: some View {
        VStack {
            text1
                .foregroundColor(.red)
            text2
                .foregroundColor(.green)
            text1
                .foregroundColor(.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
