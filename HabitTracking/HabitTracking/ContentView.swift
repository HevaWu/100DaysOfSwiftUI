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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink {
                        ActivityDetailsView(activity: activity, activities: activities)
                    } label: {
                        HStack {
                            Text(activity.title)
                            
                            Spacer()
                            
                            Text("Count: \(activity.count)")
                        }
                    }
                }
                .onDelete { indexSet in
                    removeFrom(indexSet)
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
                leading: EditButton(),
                trailing: Button(action: {
                    showAddView = true
                }, label: {
                    Image(systemName: "plus")
                })
            )
        }
    }
    
    func removeFrom(_ indexSet: IndexSet) {
        activities.items.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
