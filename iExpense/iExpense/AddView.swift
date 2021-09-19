//
//  AddView.swift
//  iExpense
//
//  Created by He Wu on 2021/09/19.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        if let actualAmount = Int(self.amount) {
                            let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                            expenses.items.append(item)
                        }
    
                    }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
