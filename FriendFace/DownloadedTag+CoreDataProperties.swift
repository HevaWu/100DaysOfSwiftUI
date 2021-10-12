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

    var wrappedName: String {
        return name ?? "Unknown Tag"
    }
}

extension DownloadedTag : Identifiable {

}
