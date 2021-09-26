//
//  ContentView.swift
//  Drawing
//
//  Created by He Wu on 2021/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .border(
                ImagePaint(
                    image: Image("bear"),
                    sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
                    scale: 1.0),
                width: 30
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
