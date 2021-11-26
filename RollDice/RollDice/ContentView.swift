//
//  ContentView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Roll Dice")
                .tabItem {
                    Image(systemName: "dice")
                    Text("Roll Dice")
                }
                .tag(0)
            
            Text("Show Previous Result")
                .tabItem {
                    Image(systemName: "square.text.square")
                    Text("Result History")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
