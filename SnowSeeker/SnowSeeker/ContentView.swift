//
//  ContentView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/11/29.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name")
            Text("Country")
            Text("Pets")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
        
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
