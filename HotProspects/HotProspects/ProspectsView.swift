//
//  ProspectsView.swift
//  HotProspects
//
//  Created by He Wu on 2021/11/08.
//

import SwiftUI

struct ProspectsView: View {
    
    enum FilterType {
        case none
        case contacted
        case uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationBarTitle(Text(title))
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Test"
                    prospect.emailAddress = "test@apple.com"
                    prospects.people.append(prospect)
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
                )
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
