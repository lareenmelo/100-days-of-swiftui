//
//  AstronautView.swift
//  Moonshot
//
//  Created by Melo, Lareen on 5/23/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    // 2
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    private var missionCount: Int
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var count = 0
        
        for mission in self.missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                count += 1
            }
        }
        
        self.missionCount = count
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        
                    // 2
                    Text("Number of missions: \(missionCount)")
                        .padding(.top)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
