//
//  Friend+CoreDataProperties.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/02.
//
//

import Foundation
import CoreData
import MapKit


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var location: String?

    var wrappedName: String {
        return name ?? "Unknown Name"
    }
    
    var profileImage: UIImage {
        guard let id = id,
              let url = FileManager.default.getDocumentDirectory()?.appendingPathComponent("\(id).jpeg"),
              let data = try? Data(contentsOf: url),
                let uiImage = UIImage(data: data) else {
                  return UIImage(systemName: "person.circle")!
              }
        return uiImage
    }
    
    var currentLocation: CodableMKPointAnnotation {
        guard let id = id,
              let filePath = FileManager.default.getDocumentDirectory()?.appendingPathComponent("location_\(id)"),
              let data = try? Data(contentsOf: filePath),
              let location = try? JSONDecoder().decode(CodableMKPointAnnotation.self, from: data) else {
                  return MKPointAnnotation.example
              }
        return location
    }
}

extension Friend : Identifiable {

}
