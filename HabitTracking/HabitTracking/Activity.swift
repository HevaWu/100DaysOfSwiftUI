//
//  Activity.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import Foundation

class Activity: Identifiable, ObservableObject {
    let id = UUID()
    var title: String
    var description: String
    @Published var count: Int
    
    init(title: String, description: String, count: Int = 1) {
        self.title = title
        self.description = description
        self.count = count
    }
}

class Activities: ObservableObject {
    @Published var items = [Activity]()
    
    init() {
        
    }
    
    init(items: [Activity]) {
        self.items = items
    }
    
    static let dummy = Activities(items: [
        Activity(title: "Learning SwiftUI", description: "Keep going", count: 1),
        Activity(title: "Playing", description: "Game", count: 1),
        Activity(title: "Dummy Title", description: "Dummy Description", count: 1),
    ])
}
