//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by He Wu on 2021/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello World")
                .alignmentGuide(.leading) { d in
                    d[.trailing]
                }
            Text("This is a longer line of text")
                .alignmentGuide(<#T##g: HorizontalAlignment##HorizontalAlignment#>, computeValue: <#T##(ViewDimensions) -> CGFloat#>)
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
