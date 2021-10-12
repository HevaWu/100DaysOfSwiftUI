//
//  DownloadedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/12.
//
//

import Foundation
import CoreData


extension DownloadedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadedUser> {
        return NSFetchRequest<DownloadedUser>(entityName: "DownloadedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?
    @NSManaged public var tags: NSSet?
    
    var wrappedTags: [DownloadedTag] {
        let tagSet = tags as? Set<DownloadedTag> ?? []
        return tagSet.sorted { $0.wrappedName < $1.wrappedName }
    }
    
    var wrappedFriends: [DownloadedFriend] {
        let friendSet = friends as? Set<DownloadedFriend> ?? []
        return Array(friendSet)
    }

    func convertToUser() -> User {
        let wrappedId = id ?? "Unknown ID"
        let wrappedName = name ?? "Unknown Name"
        let wrappedCompany = company ?? "Unknown Company"
        let wrappedEmail = email ?? "Unknown Email"
        let wrappedAddress = address ?? "Unknown Address"
        let wrappedAbout = about ?? "No about"
        let wrappedRegistered = registered ?? "Unclear Registered"
        
        let wrappedTagsArray = wrappedTags
            .map { $0.wrappedName }
        
        let wrappedFriendsArray = wrappedFriends
            .map { Friend(id: $0.wrappedId, name: $0.wrappedName) }
        
        return User(
            id: wrappedId,
            isActive: isActive,
            name: wrappedName,
            age: Int(age),
            company: wrappedCompany,
            email: wrappedEmail,
            address: wrappedAddress,
            about: wrappedAbout,
            registered: wrappedRegistered,
            tags: wrappedTagsArray,
            friends: wrappedFriendsArray
        )
    }
}

// MARK: Generated accessors for friends
extension DownloadedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: DownloadedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: DownloadedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension DownloadedUser {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: DownloadedTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: DownloadedTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension DownloadedUser : Identifiable {

}
