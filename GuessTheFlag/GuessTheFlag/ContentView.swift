//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by He Wu on 2021/09/02.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.black, lineWidth: 1)
            )
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    
    @State private var correctIndex = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    @State private var rotateAmount: Double = 0.0
    @State private var opacityAmount: Double = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctIndex])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    let isCorrectFlag = number == correctIndex
                    
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        FlagImage(imageName: self.countries[number])
                    })
                    .rotation3DEffect(
                        isCorrectFlag ? .degrees(rotateAmount) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .opacity(isCorrectFlag ? 1 : opacityAmount)
                }
                
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    askQuestion()
            })
        })
    }
    
    func flagTapped(_ index: Int) {
        if index == correctIndex {
            scoreTitle = "Correct"
            score += 1
            
            withAnimation {
                rotateAmount = 360
                opacityAmount = 0.25
            }
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[index])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctIndex = Int.random(in: 0...2)
        
        // reset rotateAmount
        rotateAmount = 0.0
        opacityAmount = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
