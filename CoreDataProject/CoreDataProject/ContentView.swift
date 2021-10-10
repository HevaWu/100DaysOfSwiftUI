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
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "shortName", filterValue: "U", sorterDescriptors: [
                NSSortDescriptor(keyPath: \Country.shortName, ascending: true),
            ]) { (country: Country) in
                Section(header: Text(country.wrappedFullName)) {
                    ForEach(country.candyArray, id: \.self) { candy in
                        Text(candy.wrappedName)
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kindom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kindom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kindom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Tobblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Swizzerland"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Ferrara"
                candy5.origin = Country(context: moc)
                candy5.origin?.shortName = "US"
                candy5.origin?.fullName = "United States"
                
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
