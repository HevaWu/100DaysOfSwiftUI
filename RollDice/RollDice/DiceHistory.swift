//
//  DiceHistory.swift
//  RollDice
//
//  Created by He Wu on 2021/11/26.
//

import Foundation
import SwiftUI
import CoreData

class DiceHistory: ObservableObject {
    @Published private(set) var records = [Int: [Int]]()
    private var savedRecords = [DiceRecord]()

    let fetchRequest: NSFetchRequest<DiceRecord>
    
    init() {
        fetchRequest = DiceRecord.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DiceRecord.side, ascending: true)]
    }
    
    func loadData() {
        PersistenceController.shared.container.performBackgroundTask { [unowned self] moc in
            // This will have effect on UI, so run it under main thread
            DispatchQueue.main.async {
                do {
                    self.savedRecords = try moc.fetch(fetchRequest)
                    self.records = [Int: [Int]]()
                    for record in savedRecords {
                        self.records[Int(record.side), default: [Int]()].append(Int(record.result))
                    }
                    
                } catch {
                    print("[DiceHisotry] Load data failed.")
                }
            }
        }
    }
    
    func addNewRecord(side: Int, result: Int) {
        PersistenceController.shared.container.performBackgroundTask { [weak self] moc in
            do {
                let diceRecord = DiceRecord(context: moc)
                diceRecord.side = Int16(side)
                diceRecord.result = Int16(result)
                
                try moc.save()
                
                self?.loadData()
            } catch {
                print("[DiceHistory] Save side and result failed.")
            }
        }
    }
    
    func clearAllData() {
        PersistenceController.shared.container.performBackgroundTask { [weak self] moc in
            guard let savedRecords = self?.savedRecords else { return }
            do {
                for record in savedRecords {
                    let _moc = record.managedObjectContext ?? moc
                    _moc.delete(record)
                    try _moc.save()
                }
//                try moc.save()
                
                self?.loadData()
            } catch {
                print("[DiceHistory] Clear All Data failed.")
            }
        }
    }
}
