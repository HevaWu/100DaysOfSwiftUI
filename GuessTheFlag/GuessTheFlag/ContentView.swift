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

struct WrongFlagViewModifier: ViewModifier {
    var isWrongFlag: Bool
    var scaleAmount: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        if isWrongFlag {
            content
                .overlay(
                    Capsule()
                        .stroke(Color.red, lineWidth: 2)
                        .scaleEffect(scaleAmount)
                        .opacity(Double(2 - scaleAmount))
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatCount(3, autoreverses: false)
                        )
                )
        } else {
            content
        }
    }
}

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
    
    @State private var scaleWrongAmount: CGFloat = 1.0
    @State private var tappedWrong = false
    
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
                            .accessibilityLabel(Text(labels[countries[number], default: "Unknown Flag"]))
                    })
                    .rotation3DEffect(
                        isCorrectFlag ? .degrees(rotateAmount) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .opacity(isCorrectFlag ? 1 : opacityAmount)
                    .modifier(WrongFlagViewModifier(isWrongFlag: tappedWrong, scaleAmount: scaleWrongAmount))
                    .onAppear(perform: {
                        if tappedWrong {
                            scaleWrongAmount = 2
                        }
                    })
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
            
            tappedWrong = true
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctIndex = Int.random(in: 0...2)
        
        // reset animation
        rotateAmount = 0.0
        opacityAmount = 1.0
        tappedWrong = false
        scaleWrongAmount = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
