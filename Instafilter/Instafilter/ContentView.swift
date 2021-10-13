//
//  ContentView.swift
//  Instafilter
//
//  Created by He Wu on 2021/10/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showActionSheet = true
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Change background"),
                    message: Text("Select one of color"),
                    buttons: [
                        .default(Text("Red")) { backgroundColor = .red },
                        .default(Text("Green")) { backgroundColor = .green},
                        .default(Text("Blue")) { backgroundColor = .blue },
                        .cancel()
                    ])
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
