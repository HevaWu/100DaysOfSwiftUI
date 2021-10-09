//
//  ContentView.swift
//  CoreDataProject
//
//  Created by He Wu on 2021/10/08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    // format: "universe in %@", ["A", "B", "Star Trek"]
    // format: "name BEGINSWITH %@", "E"
    // format: "name BEGINSWITH[c] %@", "e"
    // format: "NOT name BEGINSWITH[c] %@", "e"
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe in %@" , ["A", "B", "Star Trek"])) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Miilenium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
