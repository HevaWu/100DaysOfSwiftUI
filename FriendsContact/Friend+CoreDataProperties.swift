//
//  Friend+CoreDataProperties.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/01.
//
//

import Foundation
import CoreData
import UIKit


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    var wrappedName: String {
        return name ?? "Unknown Name"
    }
    
    var profileImage: UIImage? {
        guard let id = id,
              let url = FileManager.default.getDocumentDirectory()?.appendingPathComponent("\(id).jpeg"),
              let data = try? Data(contentsOf: url) else {
                  return nil
              }
        return UIImage(data: data)
    }
}

extension Friend : Identifiable {

}
