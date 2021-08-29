//
//  ContentView.swift
//  WeSplit
//
//  Created by He Wu on 2021/08/29.
//

import SwiftUI

struct ContentView: View {
    let students = ["Alice", "Bob", "Henry"]
    @State private var selectedStudent = "Alice"
    
    var body: some View {
        Picker("Please Select Students", selection: $selectedStudent) {
            ForEach(0..<students.count) {
                Text(students[$0])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
