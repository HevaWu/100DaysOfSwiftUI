//
//  ContentView.swift
//  Bookworm
//
//  Created by He Wu on 2021/10/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return AnyView(
                VStack {
                    Text("Active size class:")
                    Text("COMPACT")
                }
                    .font(.largeTitle)
            )
        } else {
            return AnyView(
                HStack {
                    Text("Active size class:")
                    Text("REGULAR")
                }
                    .font(.largeTitle)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
