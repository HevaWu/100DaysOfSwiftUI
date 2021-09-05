//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct ContentView: View {
    @State private var useRed = false
    
    var body: some View {
        Button("Hello, world!") {
            self.useRed.toggle()
        }
        .foregroundColor(useRed ? .red : .black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
