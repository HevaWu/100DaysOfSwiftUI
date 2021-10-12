//
//  DownloadedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/12.
//
//

import Foundation
import CoreData


extension DownloadedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadedFriend> {
        return NSFetchRequest<DownloadedFriend>(entityName: "DownloadedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var userList: NSSet?

    var wrappedId: String {
        return id ?? "Unknown ID"
    }
    
    var wrappedName: String {
        return name ?? "Unknown Friend Name"
    }
}

// MARK: Generated accessors for userList
extension DownloadedFriend {

    @objc(addUserListObject:)
    @NSManaged public func addToUserList(_ value: DownloadedUser)

    @objc(removeUserListObject:)
    @NSManaged public func removeFromUserList(_ value: DownloadedUser)

    @objc(addUserList:)
    @NSManaged public func addToUserList(_ values: NSSet)

    @objc(removeUserList:)
    @NSManaged public func removeFromUserList(_ values: NSSet)

}

extension DownloadedFriend : Identifiable {

}
