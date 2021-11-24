//
//  ContentView.swift
//  WordScramble
//
//  Created by He Wu on 2021/09/11.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List(usedWords, id: \.self) { word in
                        GeometryReader { wordGeo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(
                                        Color(
                                            red: Double(Int(wordGeo.frame(in: .global).minY) % Int(geo.size.height)) / Double(geo.size.height),
                                            green: Double(1 - Double(Int(wordGeo.frame(in: .global).minY) % Int(geo.size.height)) / Double(geo.size.height)),
                                            blue: Double(0.5 * Double(Int(wordGeo.frame(in: .global).minY) % Int(geo.size.height)) / Double(geo.size.height))
                                        )
                                    )
                                Text(word)
                            }
                            .offset(x: max(0, Double(wordGeo.frame(in: .global).minY + wordGeo.size.width - geo.frame(in: .global).maxY)))
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(Text("\(word), \(word.count) letters"))
                        }
                    }
                    
                    Text("Score: \(score)")
                }
                .navigationBarTitle(rootWord)
                .onAppear(perform: startGame)
                .alert(isPresented: $showError, content: {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                })
                .navigationBarItems(
                    leading: Button("Reset Start Word", action: resetGame)
                )
            }
        }
    }
    
    func resetGame() {
        startGame()
        usedWords = []
        newWord = ""
        
        errorTitle = ""
        errorMessage = ""
        showError = false
        
        score = 0
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
    
    // longer than 3 letters
    func isLongerThanThree(word: String) -> Bool {
        return word.count >= 3
    }
    
    // is atualy english word or not
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    // not trying to spell "car" from `silkworm`
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    // word hasn't been used
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let startWords = try? String(contentsOf: startWordURL) {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "unknown"
            return
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else { return }
        
        guard isLongerThanThree(word: answer) else {
            wordError(title: "Word shorter than 3 letters", message: "Input more letters")
            return
        }
        
        guard isOriginal(word: answer) && answer != rootWord else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "Cannot make up")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "Word not possible", message: "Not a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        
        score += answer.count
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
