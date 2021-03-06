//
//  ContentView.swift
//  iExpense
//
//  Created by He Wu on 2021/09/18.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    let labelColor: Color = {
                        switch item.amount {
                        case 0..<10:
                            return .blue
                        case 10..<100:
                            return .yellow
                        default:
                            // over 100
                            return .red
                        }
                    }()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text("\(item.amount)")
                            .foregroundColor(labelColor)
                    }
                }
                .onDelete(perform: { indexSet in
                    removeItems(at: indexSet)
                })
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        showAddExpense = true
                    }, label: {
                        Image(systemName: "plus")
                    })
            )
            .sheet(isPresented: $showAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
