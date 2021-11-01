//
//  FriendsContactApp.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import SwiftUI

@main
struct FriendsContactApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
