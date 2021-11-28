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
            List {
                ForEach(diceHistory.records.keys.sorted(), id: \.self) { diceSide in
                    if let diceResults = diceHistory.records[diceSide] {
                        Section(header: Text("\(diceSide)-sided")) {
                            ForEach(diceResults, id: \.self) { diceResult in
                                Text("\(diceResult)")
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Results History"))
        }
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
