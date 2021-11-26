//
//  UserHistoryView.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import SwiftUI

struct UserHistoryView: View {
    @EnvironmentObject var diceHistory: DiceHistory
    
    var body: some View {
        NavigationView {
            List(diceHistory.results, id: \.self) { result in
                Text("\(result)")
            }
            .navigationBarTitle(Text("Results History"))
        }
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
