//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .frame(width: .infinity, height: .infinity)
            .background(Color.red)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
