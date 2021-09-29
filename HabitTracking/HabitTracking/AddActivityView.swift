//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import SwiftUI

struct AddActivityView: View {
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Input Title", text: $title)
                }
                
                Section(header: Text("Description")) {
                    TextField("Input Descriptionn", text: $description)
                }
            }
            .navigationTitle("Add/Edit Activity")
            .navigationBarItems(
                trailing: Button("Save", action: {
                    self.addCurrentActivity()
                    presentationMode.wrappedValue.dismiss()
                })
            )
        }
    }
    
    func addCurrentActivity() {
        let activity = Activity(title: self.title, description: self.description)
        activities.items.append(activity)
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
