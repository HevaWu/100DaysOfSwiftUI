//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct TitleView: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
}

extension View {
    func titleView() -> some View {
        self.modifier(TitleView())
    }
}

struct ContentView: View {

    var body: some View {
        Text("Hello World!")
            .titleView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
