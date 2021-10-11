//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/11.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
