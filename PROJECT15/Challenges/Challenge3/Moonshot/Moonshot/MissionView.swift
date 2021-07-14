//
//  MissionView.swift
//  Moonshot
//
//  Created by Melo, Lareen on 5/23/21.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                        
                    
                    // 1
                    Text(self.mission.formattedLaunchDate)
                        .fontWeight(.bold)
                        .padding(.top)
                        .accessibility(label: Text(self.mission.accessibleLaunchDate))
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(decorative: crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                        .accessibility(label: Text(accessibilityAustronautName(crewMember.astronaut.name)))

                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                        .accessibility(label: Text(crewMember.role))
                                        .accessibility(value: Text("Role"))

                                    
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    struct CrewMember: Codable {
        let role: String
        let astronaut: Astronaut
    }
    
    func accessibilityAustronautName(_ name: String) -> String {
        return name.replacingOccurrences(of: ".", with: " ")
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
