//
//  FileManager+Extension.swift
//  Moonshot
//
//  Created by He Wu on 2021/10/19.
//

import Foundation

extension FileManager {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = getURL(for: file) else {
            fatalError("Failed to loacate file in \(file)")
        }
        print("[FileManager] find \(url) successfully")
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read data in \(file) under \(url)")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode [Astronaut] in \(file)")
        }
        return decoded
    }
    
    private func getURL(for file: String) -> URL? {
        if let documentDir = urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = documentDir.appendingPathComponent(file)
            if let _ = try? url.checkResourceIsReachable() {
                return url
            } else {
                // read file from bundle , then write it under document path
                guard let bundleUrl = Bundle.main.url(forResource: file, withExtension: nil),
                      let data = try? Data(contentsOf: bundleUrl) else {
                    fatalError("Failed to read data in \(file)")
                }
            
                NSData(data: data).write(to: url, atomically: true)
                return url
            }
        } else {
            fatalError("Failed to find document dir")
        }
    }
}
