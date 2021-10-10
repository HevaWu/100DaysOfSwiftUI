//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by He Wu on 2021/10/10.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(predicateFilterKey: String,
         predicateFilterValue: String,
         predicateStringComparison: PredicateStringComparison,
         sorterDescriptors: [NSSortDescriptor],
         @ViewBuilder content: @escaping (T) -> Content
    ) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sorterDescriptors,
            predicate: NSPredicate(format: "%K \(predicateStringComparison.rawValue) %@", predicateFilterKey, predicateFilterValue)
        )
        self.content = content
    }
}

enum PredicateStringComparison: String {
    case beginsWith = "BEGINSWITH"
    case greaterThanOrEqualTo = ">="
    case lessThanOrEqualTo = "<="
}
