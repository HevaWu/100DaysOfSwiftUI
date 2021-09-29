//
//  ActivityDetailsView.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import SwiftUI

struct ActivityDetailsView: View {
    var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Description")) {
                Text(activity.description)
            }
            
            Section(header: Text("How many times?")) {
                Text("\(activity.count)")
            }
        }
        .navigationTitle(Text(activity.title))
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsView(activity: Activity(title: "Dummy Title", description: "Dummy Description"))
    }
}
