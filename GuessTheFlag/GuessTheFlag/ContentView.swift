//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by He Wu on 2021/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0).edgesIgnoringSafeArea(.all)
            Text("Hello World")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
