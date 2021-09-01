//
//  ContentView.swift
//  UnitConversation
//
//  Created by He Wu on 2021/09/01.
//

import SwiftUI

// Do Length Conversation

struct ContentView: View {
    @State var inputUnit = 0
    @State var outputUnit = 0
    @State var inputNumber = ""
    
    var outputNumber: Double {
        let inputNum = Double(inputNumber) ?? 0
        if inputUnit == outputUnit {
            return inputNum
        }
        
        let inputToZero = Measurement(value: inputNum, unit: units[inputUnit])
        return inputToZero.converted(to: units[outputUnit]).value
    }
    
    let units = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Unit(Length)")) {
                    TextField("Please input a number", text: $inputNumber)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Length", selection: $inputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output Unit(Length)")) {
                    Text("Output Number is \(outputNumber)")
                    
                    Picker("Output Length", selection: $outputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Length Conversation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
