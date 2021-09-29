//
//  Activity.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var count: Int
    
    init(title: String, description: String, count: Int = 1) {
        self.title = title
        self.description = description
        self.count = count
    }
}

class Activities: ObservableObject {
    static let storeKey = "io.github.hevawu.HabitTracking.activities"
    
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: Self.storeKey)
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: Self.storeKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
            }
        }
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
