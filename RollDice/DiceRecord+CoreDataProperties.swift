//
//  DiceRecord+CoreDataProperties.swift
//  RollDice
//
//  Created by He Wu on 2021/11/28.
//
//

import Foundation
import CoreData


extension DiceRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceRecord> {
        return NSFetchRequest<DiceRecord>(entityName: "DiceRecord")
    }

    @NSManaged public var result: Int16
    @NSManaged public var side: Int16

}

extension DiceRecord : Identifiable {

}
