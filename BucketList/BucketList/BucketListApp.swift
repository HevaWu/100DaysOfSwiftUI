//
//  BucketListApp.swift
//  BucketList
//
//  Created by He Wu on 2021/10/19.
//

import SwiftUI

@main
struct BucketListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
