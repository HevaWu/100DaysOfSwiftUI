//
//  ContentView.swift
//  BetterRest
//
//  Created by He Wu on 2021/09/08.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var showBedTime = false
    @State private var sleepTime = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityValue(Text("\(sleepAmount, specifier: "%g") hours"))
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            if sleepAmount < 12 {
                                sleepAmount += 0.25
                            }
                            
                        case .decrement:
                            if sleepAmount > 4 {
                                sleepAmount -= 0.25
                            }
                        @unknown default:
                            break
                        }
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) { cup in
                            if cup == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(cup) cups")
                            }
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                }
                
                if showBedTime {
                    Section(header: Text("Recommended Bedtime")) {
                        HStack(spacing: 10) {
                            Text("Bedtime: ")
                            
                            Text(sleepTime)
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("BetterRest")
            .navigationBarItems(
                trailing:
                    Button("Calculate") {
                        self.calculateBedtime()
                    }
            )
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(input: SleepCalculatorInput(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)))
            
            let _sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            sleepTime = formatter.string(from: _sleepTime)
            
            alertTitle = "Your ideal bedtime is ... "
            alertMessage = sleepTime
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, There was a problem calculating your bedtime."
        }
        
        showBedTime = true
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
