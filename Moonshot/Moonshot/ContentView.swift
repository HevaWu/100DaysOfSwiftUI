//
//  ContentView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = FileManager.default.decode("astronauts.json")
    let missions: [Mission] = FileManager.default.decode("missions.json")
    
    @State private var showLaunchDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions),
                    label: {
                        Image(mission.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            
                            if showLaunchDate {
                                Text(mission.formattedLaunchDate)
                            } else {
                                Text(mission.crewNames)
                            }
                        }
                    })
            }
            .navigationBarItems(
                trailing: Button(showLaunchDate ? "Show Crew Names" : "Show Launch Dates") {
                    showLaunchDate.toggle()
            })
            .navigationBarTitle("Moonshot")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
