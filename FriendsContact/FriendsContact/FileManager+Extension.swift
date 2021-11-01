//
//  FileManager+Extension.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//

import Foundation

extension FileManager {
    func getDocumentDirectory() -> URL? {
        if let path = urls(for: .documentDirectory, in: .userDomainMask).first {
            return path
        } else {
            print("[FileManager] Get Document Directory failed.")
            return nil
        }
    }
}
