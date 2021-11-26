//
//  RollDiceView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI

struct RollDiceView: View {
    @EnvironmentObject var diceHistory: DiceHistory
    
    @State private var isShowDice = false
    
    @State private var diceNumber = 0
    
    var body: some View {
        VStack {
            Button {
                startRollingDice()
            } label: {
                Text("Start Game")
            }

            if isShowDice {
                Text("\(diceNumber)")
            }
        }
    }
    
    private func startRollingDice() {
        diceNumber = Int.random(in: 1...4)
        diceHistory.results.append(diceNumber)
        
        print(diceHistory.results)
        isShowDice = true
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
