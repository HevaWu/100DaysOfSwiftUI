//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by He Wu on 2021/10/08.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
