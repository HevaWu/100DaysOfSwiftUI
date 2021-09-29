//
//  ContentView.swift
//  HabitTracking
//
//  Created by He Wu on 2021/09/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    
    @State private var showAddView = false
    
    @State private var count = 0
    
    var body: some View {
        NavigationView {
            List(activities.items) { activity in
                NavigationLink {
                    ActivityDetailsView(activity: activity)
                } label: {
                    HStack {
                        Text(activity.title)
                    }
                }
            }
            .sheet(
                isPresented: $showAddView,
                onDismiss: {
                    showAddView = false
                },
                content: {
                    AddActivityView(activities: activities)
                }
            )
            .navigationTitle("All Activities")
            .navigationBarItems(
                trailing: Button(action: {
                    showAddView = true
                }, label: {
                    Image(systemName: "plus")
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
