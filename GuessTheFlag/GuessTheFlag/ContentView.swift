//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by He Wu on 2021/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("a00")
                Text("a01")
                Text("a02")
            }
            HStack {
                Text("a10")
                Text("a11")
                Text("a12")
            }
            HStack {
                Text("a20")
                Text("a21")
                Text("a22")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
