//
//  DownloadedTag+CoreDataProperties.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/12.
//
//

import Foundation
import CoreData


extension DownloadedTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadedTag> {
        return NSFetchRequest<DownloadedTag>(entityName: "DownloadedTag")
    }

    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?
    
    var wrappedName: String {
        return name ?? "Unknown Tag"
    }
}

// MARK: Generated accessors for users
extension DownloadedTag {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: DownloadedUser)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: DownloadedUser)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension DownloadedTag : Identifiable {

}
