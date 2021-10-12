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

    var wrappedId: String {
        return id ?? "Unknown ID"
    }
    
    var wrappedName: String {
        return name ?? "Unknown Friend Name"
    }
}

extension DownloadedFriend : Identifiable {

}
