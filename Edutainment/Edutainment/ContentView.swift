//
//  ContentView.swift
//  Edutainment
//
//  Created by He Wu on 2021/09/17.
//

import SwiftUI

struct ContentView: View {
    @State private var difficult = 5
    @State private var questionCount = 3
    
    @State private var showSettingView = true
    
    var questionCountList = ["5", "10", "20", "ALL"]
    
    var settingView: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Define Difficulty")) {
                        Stepper("Up to \(difficult)", value: $difficult, in: 1...12)
                    }
                    
                    Section(header: Text("How many questions?")) {
                        
                        Picker("Question Count", selection: $questionCount) {
                            ForEach(0..<questionCountList.count) {
                                Text("\(questionCountList[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Button(action: {
                    startGame()
                }, label: {
                    Text("Start Game!")
                })
                .font(.title)
                .frame(width: 200, height: 200)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
                
                Spacer()
                    .frame(maxHeight: .infinity)
            }
            .navigationTitle("Set up Your Game")
        }
    }
    
    var body: some View {
        settingView
    }
    
    func startGame() {
        print("tapped start game!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
