//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing, content: {
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
        })
            
    }
}

extension View {
    func wartermark(_ text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {

    var body: some View {
        VStack {
            Text("Hello World!")
                .titleStyle()
            
            Color.green
                .wartermark("Watermarked")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
