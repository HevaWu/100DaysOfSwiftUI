//
//  ContentView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
