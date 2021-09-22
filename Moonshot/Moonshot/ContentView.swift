//
//  ContentView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/22.
//

import SwiftUI

struct CustomTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("CustomTextView initialized.")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomTextView("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
