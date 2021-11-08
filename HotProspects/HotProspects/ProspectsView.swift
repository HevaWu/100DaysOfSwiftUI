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
    
    var body: some View {
        NavigationView {
            Text("Hello World")
                .navigationBarTitle(Text(title))
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
