//
//  Prospect.swift
//  HotProspects
//
//  Created by He Wu on 2021/11/08.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let savedKey = "savedData"
    
    init() {
        if let filePath = Self.getFilePathUrl(),
           let data = try? Data(contentsOf: filePath),
           let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
            people = decoded
            return
        }
        
        people = []
    }
    
    func save() {
        if let filePath = Self.getFilePathUrl(),
           let data = try? JSONEncoder().encode(people) {
//            print(data, filePath)
            try? data.write(to: filePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    static func getFilePathUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("savedData.json")
    }
}
