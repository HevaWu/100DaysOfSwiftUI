//
//  ContentView.swift
//  Drawing
//
//  Created by He Wu on 2021/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Capsule()
            .strokeBorder(
                ImagePaint(
                    image: Image("bear"),
                    scale: 1),
                lineWidth: 30)
            .frame(width: 300, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
