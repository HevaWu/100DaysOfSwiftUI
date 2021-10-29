//
//  AstronautView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/23.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let matchedMissions: [Mission]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibilityHidden(true)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Current Missions")
                        .font(.title)
                    
                    ForEach(matchedMissions) { mission in
                        HStack(alignment: .top, spacing: 10) {
                            Image(mission.imageName)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .accessibilityHidden(true)
                            
                            Text(mission.description)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        let matched: [Mission] = missions.filter { mission in
            mission.crew.contains(where: { $0.name == astronaut.id })
        }
        self.matchedMissions = matched
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = FileManager.default.decode("astronauts.json")
    static let missions: [Mission] = FileManager.default.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
