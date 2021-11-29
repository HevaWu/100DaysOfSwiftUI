//
//  ContentView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/11/29.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name")
            Text("Country")
            Text("Pets")
        }
    }
}

struct ContentView: View {
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            layoutVertically.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
