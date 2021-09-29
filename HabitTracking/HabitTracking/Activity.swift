//
//  Activity.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import Foundation

struct Activity: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var count = 1
}

class Activities: ObservableObject {
    @Published var items = [Activity]()
}
