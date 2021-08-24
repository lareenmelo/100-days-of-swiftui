//
//  ContentView.swift
//  Dados
//
//  Created by Lareen Melo on 8/17/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Roll")
                }
            
            ScoreboardView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Scores")
                }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
