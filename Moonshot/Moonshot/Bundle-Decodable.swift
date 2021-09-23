//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/23.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to loacate file in \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read data in \(file) under \(url)")
        }
        
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode [Astronaut] in \(file)")
        }
        return decoded
    }
}
