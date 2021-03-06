//
//  RollDiceView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject var diceHistory: DiceHistory
    
    @State private var isShowAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var isShowDice = true
    @State private var diceNumber = 0
    @State private var diceType = 0
    
    let diceTypeList = [4, 6, 8, 10, 12, 20, 100]
    
    var selectedDiceSide: Int {
        diceTypeList[diceType]
    }
    
    var totalPoint: Int {
        diceHistory.records.values.reduce(into: 0) { point, resultArr in
            point += resultArr.reduce(into: 0, { temp, next in
                temp += next
            })
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pick Your Dice Side")) {
                    Picker("Pick Your Dice Side", selection: $diceType) {
                        ForEach(0..<diceTypeList.count) { index in
                            Text("\(diceTypeList[index])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if isShowDice {
                    Section(header: Text("Total Rolled Point")) {
                        HStack {
                            Text("Your Point is:")
                                .bold()
                            Text("\(totalPoint)")
                        }
                    }
                    
                    Section(header: Text("Dices")) {
                        Text("\(diceNumber)")
                            .frame(width: 300, height: 300, alignment: .center)
                    }
                }
            }
            .navigationBarItems(
                // TODO: Fix reset function later
//                leading: Button(action: {
//                    // show reset game alert
//                    alertTitle = "Are you sure RESET the game?"
//                    alertMessage = "Please notice you will lose all of dice history if reset the game."
//                    isShowAlert = true
//                }, label: {
//                    Image(systemName: "gobackward")
//                }),
                trailing: Button(action: {
                    startRollingDice()
                }, label: {
                    HStack {
                        Image(systemName: "dice.fill")
                        Text("Start")
                            .font(.title2)
                            .bold()
                    }
                })
            )
            .navigationBarTitle(Text("Roll Dice"))
            .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    primaryButton: Alert.Button.default(Text("Reset"), action: {
                        resetGame()
                    }),
                    secondaryButton: Alert.Button.cancel(Text("Cancel")))
            }
        }
    }
    
    private func startRollingDice() {
        triggerHaptic()

        showRandomVariousDice {
            diceNumber = Int.random(in: 1...selectedDiceSide)
            diceHistory.addNewRecord(side: selectedDiceSide, result: diceNumber)
        }

        isShowDice = true
    }
    
    private func resetGame() {
        diceHistory.clearAllData()
        
        isShowAlert = false
        alertTitle = ""
        alertMessage = ""
        
        isShowDice = true
        diceNumber = 0
        diceType = 0
    }
    
    private func triggerHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    private func showRandomVariousDice(completion: @escaping () -> Void) {
        var start = 0.0
        var step = 0.001
        let end = 3.0
        while true {
            start += step
            guard start <= end else { break }
            
            step *= 2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(start)) {
                diceNumber = Int.random(in: 1...selectedDiceSide)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
        
        // Timer
//        var count = 0
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            count += 1
//            diceNumber = Int.random(in: 1...selectedDiceSide)
//
//            if count == 20 {
//                timer.invalidate()
//            }
//        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
