//
//  ContentView.swift
//  Instafilter
//
//  Created by He Wu on 2021/10/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("BlurAmount is \(blurAmount)")
        }
    }

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("Blur value is \(self.blurAmount)")
            }
        )
        
        return VStack {
            Text("Hello World")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
