//
//  RollDiceView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI

struct RollDiceView: View {
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
        isShowDice = true
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
