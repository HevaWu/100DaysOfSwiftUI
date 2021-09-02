//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by He Wu on 2021/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            print("Button Taped")
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: "pencil")
                Text("Edit")
            }
        })
//        Button("Tap me") {
//            print("Button Taped")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
