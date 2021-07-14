//
//  ContentView.swift
//  Moonshot
//
//  Created by Melo, Lareen on 5/22/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    // 3
    @State private var showCrewNames = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        // 3
                        Text(mission.displayName)
                        .font(.headline)
                        
                        if showCrewNames {
                            Text(crewMembers(mission))
                                .accessibility(label: Text(accessibleCrewNames(mission)))

                        } else {
                            Text(mission.formattedLaunchDate)
                                .accessibility(label: Text(mission.accessibleLaunchDate))
                        }
                    }
                }
                .accessibility(removeTraits: .isButton)
            }
            .navigationBarTitle("Moonshot")
            // 3
            .navigationBarItems(trailing: Button(action: {
                self.showCrewNames.toggle()
            }, label: {
                Text(showCrewNames ? "Show Launch Date" : "Show Crew Members")
            }))
        }
    }
    
    // 3
    func crewMembers(_ mission: Mission) -> String {
        var string = ""
        var astronautsNames = [String]()
        for member in mission.crew {
            if let match = self.astronauts.first(where: {$0.id == member.name} ) {
                astronautsNames.append(match.name)
            }
        }
        
        string = astronautsNames.joined(separator: ", ")
        
        return string
    }
    
    func accessibleCrewNames(_ mission: Mission) -> String {
        var string = ""
        var astronautsNames = [String]()
        for member in mission.crew {
            if let match = self.astronauts.first(where: {$0.id == member.name} ) {
                astronautsNames.append(match.name)
            }
        }
        
        string = astronautsNames.joined(separator: ", ")
        
        
        return string.replacingOccurrences(of: ".", with: " ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
