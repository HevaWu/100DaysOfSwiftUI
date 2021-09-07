//
//  ContentView.swift
//  BrainTraining
//
//  Created by He Wu on 2021/09/07.
//

import SwiftUI

struct TitleWithMessage: View {
    let title: String
    let message: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
            Text(message)
                .foregroundColor(.green)
                .fontWeight(.bold)
        }
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var pcpicked = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var shouldShowAlert = false
    @State private var aroundCount = 0
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        Form {
            Section(header: Text("Player's Score")) {
                TitleWithMessage(
                    title: "Current Score is: ",
                    message: "\(score)"
                )
            }
            
            Section(header: Text("PC's Choice")) {
                TitleWithMessage(
                    title: "PC's Move:",
                    message: choices[pcpicked]
                )
                
                TitleWithMessage(
                    title: "Prompt Win?",
                    message: shouldWin.description
                )
            }
            
            Section(header: Text("Your Choice")) {
                ForEach(0..<3) { userChoice in
                    Button(action: {
                        userTapped(userChoice)
                    }, label: {
                        Text("\(choices[userChoice])")
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                    })
                    .frame(width: 100, height: 50)
                    .background(Color(.gray))
                    .clipShape((RoundedRectangle(cornerRadius: 30)))
                }
            }
        }
        .alert(isPresented: $shouldShowAlert, content: {
            Alert(
                title: Text("Finished. Your Score is \(score)."),
                dismissButton: .default(Text("Reset Game?"), action: {
                    resetGame()
                })
            )
        })
    }
    
    func resetGame() {
        score = 0
        shouldShowAlert = false
        aroundCount = 0
        
        pcpicked = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func userTapped(_ userPicked: Int) {
        let userIsWin: Bool = {
            if userPicked == (pcpicked + 1) % 3 {
                return true
            }
            return false
        }()
        
        if shouldWin == userIsWin {
            score += 1
        } else {
            score -= 1
        }
        
        pcpicked = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        
        aroundCount += 1
        if aroundCount > 10 {
            shouldShowAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
