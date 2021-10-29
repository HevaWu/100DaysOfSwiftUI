//
//  MissionView.swift
//  Moonshot
//
//  Created by He Wu on 2021/09/23.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                        .accessibilityHidden(true)
                    
                    Text("Launch Date: \(mission.formattedLaunchDate)")
                        .padding()
                    
                    Text(mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut, missions:  self.missions),
                            label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.primary, lineWidth: 1)
                                        )
                                        .accessibilityHidden(true)
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
        self.mission = mission
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Failed to find Astronaut \(member.name)")
            }
        }
        self.astronauts = matches
        self.missions = missions
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = FileManager.default.decode("missions.json")
    static let astronauts: [Astronaut] = FileManager.default.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, missions: missions)
    }
}
