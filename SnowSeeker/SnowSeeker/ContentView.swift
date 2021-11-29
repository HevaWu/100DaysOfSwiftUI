//
//  ContentView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/11/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello, world!")
                .navigationBarTitle(Text("Primary"))
            
            Text("Secondary") 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
