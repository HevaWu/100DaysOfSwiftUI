//
//  ContentView.swift
//  Edutainment
//
//  Created by He Wu on 2021/09/17.
//

import SwiftUI

struct Question {
    var image: UIImage?
    
    var param1 = 1
    var param2 = 1
    var answer = -1
}

struct OrangeButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ContentView: View {
    // setting view property
    @State private var difficulty = 5
    @State private var questionIndex = 3
    
    @State private var questionArr = [Question]()
    
    @State private var didGameStart = false
    
    var maxQuestionCount: Int {
        return difficulty * difficulty
    }
    
    var questionCountList = ["5", "10", "20", "ALL"]
    
    var imageResources: [UIImage] = {
        print("get resources")
        
        guard let paths = Bundle.main.urls(forResourcesWithExtension: ".png", subdirectory: "KenneyResources/") else {
            return [UIImage]()
        }
        
        return paths
            .compactMap { imageURL in
                UIImage(contentsOfFile: imageURL.path)
            }
    }()
    
    @State private var currentQuestionIndex = -1
    
    @State private var answer = ""
    @State private var score = 0
    
    @State private var showScore = false
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // Animation
    
    @State private var startButtonScaleAmount: CGFloat = 1
    
    // MARK: - Game View
    var gameView: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showScore.toggle()
                        countUserScore()
                    }, label: {
                        Text(showScore ? "Hide Current Score" : "Show Current Score")
                    })
                    .modifier(OrangeButtonViewModifier())
                    
                    Button(action: {
                        backToSettings()
                    }, label: {
                        Text("Back to Settings")
                    })
                    .modifier(OrangeButtonViewModifier())
                    
                    Button(action: {
                        resetGame()
                    }, label: {
                        Text("Reset Game")
                    })
                    .modifier(OrangeButtonViewModifier())
                }
                
                if showScore {
                    Text("Your Score is: \(score)")
                        .padding(.vertical)
                        .font(.title)
                }
                
                List(0..<questionArr.count) { index in
                    HStack {
                        if let image = questionArr[index].image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                        
                        Text("\(questionArr[index].param1) x \(questionArr[index].param2) = ")
                        
                        if index == currentQuestionIndex {
                            TextField("Input Your Answer at Here", text: $answer, onCommit: {
                                storeAnswer()
                            })
                            .keyboardType(.decimalPad)
                        } else {
                            Button(action: {
                                currentQuestionIndex = index
                            }, label: {
                                if questionArr[index].answer == -1 {
                                    Text("?")
                                } else {
                                    Text("\(questionArr[index].answer)")
                                }
                            })
                        }
                    }
                }
            }
            .navigationTitle("Game is running ... ")
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Back to Game?"))
                )
            })
        }
    }
    
    func clearState() {
        questionArr = [Question]()
        currentQuestionIndex = -1
        answer = ""
        score = 0
        showScore = false
        showAlert = false
        alertTitle = ""
        alertMessage = ""
    }
    
    func backToSettings() {
        didGameStart = false
        clearState()
    }
    
    func resetGame() {
        clearState()
        startGame()
    }
    
    func storeAnswer() {
        if let val = Int(answer) {
            questionArr[currentQuestionIndex].answer = val
        } else {
            showAlert(title: "Error", message: "Please input valid digit.")
        }
        
        answer = ""
        currentQuestionIndex = -1
    }
    
    func showAlert(title: String, message: String) {
        showAlert = true
        alertTitle = title
        alertMessage = message
    }
    
    func countUserScore() {
        score = 0
        
        for i in 0..<questionArr.count {
            if questionArr[i].param1 * questionArr[i].param2 == questionArr[i].answer {
                score += 1
            }
        }
    }
    
    // MARK: - Setting View
    
    var settingView: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Define Difficulty")) {
                        Stepper("Up to \(difficulty)", value: $difficulty, in: 1...12)
                    }
                    
                    Section(header: Text("How many questions?")) {
                        
                        Picker("Question Count", selection: $questionIndex) {
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
    
    func startGame() {
        clearState()
        
        let questionCount = questionIndex == 3 ? maxQuestionCount : (Int(questionCountList[questionIndex]) ?? maxQuestionCount)
        
        for _ in 0..<questionCount {
            let image = imageResources.randomElement()
            let first = Int.random(in: 1..<difficulty)
            let second = Int.random(in: 1..<difficulty)
            
            questionArr.append(Question(image: image, param1: first, param2: second))
        }
        
        didGameStart = true
        
        print("tapped start game!")
    }
    
    // MARK: - Body
    
    var body: some View {
        if didGameStart {
            gameView
        } else {
            settingView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
