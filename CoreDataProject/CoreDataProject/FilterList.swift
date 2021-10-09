//
//  FilterList.swift
//  CoreDataProject
//
//  Created by He Wu on 2021/10/09.
//

import SwiftUI
import CoreData

struct FilterList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}

