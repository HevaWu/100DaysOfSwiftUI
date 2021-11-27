//
//  RollDiceView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject var diceHistory: DiceHistory
    
    @State private var isShowDice = true
    
    @State private var diceNumber = 0
    
    @State private var diceType = 0
    let diceTypeList = [4, 6, 8, 10, 12, 20, 100]
    
    var selectedDiceSide: Int {
        diceTypeList[diceType]
    }
    
    var totalPoint: Int {
        diceHistory.results.values.reduce(into: 0) { point, resultArr in
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
            .navigationBarItems(trailing: Button {
                startRollingDice()
            } label: {
                HStack {
                    Image(systemName: "dice.fill")
                    Text("Start")
                        .font(.title2)
                        .bold()
                }
            })
            .navigationBarTitle(Text("Roll Dice"))
        }
    }
    
    private func startRollingDice() {
        diceNumber = Int.random(in: 1...selectedDiceSide)
        diceHistory.results[selectedDiceSide, default: [Int]()].append(diceNumber)
        
        isShowDice = true
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
