//
//  ActivityDetailsView.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import SwiftUI

struct ActivityDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    @ObservedObject var activity: Activity
    
    init(activity: Activity, activities: Activities) {
        self.activity = activity
        self.activities = activities
        
        _count = State(initialValue: activity.count)
    }
    
    @State private var count: Int
    
    var body: some View {
        Form {
            Section(header: Text("Description")) {
                Text(activity.description)
            }
            
            Section(header: Text("How many times?")) {
                Stepper("\(count)", value: $count, in: 1...50)
            }
        }
        .navigationTitle(Text(activity.title))
        .navigationBarItems(
            trailing: Button(action: {
                if let index = activities.items.firstIndex(where: { $0.id == self.activity.id }) {
                    activities.items.remove(at: index)
                }
                activity.count = self.count
                activities.items.append(activity)
                
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            })
        )
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsView(activity: Activity(title: "Dummy Title", description: "Dummy Description"), activities: Activities.dummy)
    }
}
