//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Melo, Lareen on 5/8/21.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["Rock", "Paper", "Scissors"]
    @State private var selectedMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var counter = 0
    @State private var showScore = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text(moves[selectedMove])
                .font(.largeTitle)
                .foregroundColor(.purple)
                .fontWeight(.heavy)
            
            HStack {
                Text("How can you")
                Text(shouldWin ? "win" : "lose")
                    .foregroundColor(shouldWin ? Color.green : Color.red)
                    .fontWeight(.bold)
                Text("this game?")
            }
            .font(.title2)
            
            HStack {
                ForEach(0..<moves.count) { number in
                    Button(action: {
                        moveTapped(number)
                    }, label: {
                        VStack {
                            Text(setEmoji(at: number))
                            Text(moves[number])
                        }
                        .font(.title3)
                        
                    })
                    .accentColor(.purple)
                }
            }
            
            if showScore {
                Text("Final score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                    .fontWeight(.heavy)
            }
            
        }
        
    }
    
    func setEmoji(at index: Int) -> String {
        switch index {
        case 0:
            return "✊"
        case 1:
            return "🖐"
        case 2:
            return "✌️"
        default:
            return ""
        }
    }
    
    func moveTapped(_ selection: Int) {
        var beatingMove: Int
        var selectionBeatsDefault: Bool
        
        switch moves[selectedMove] {
        case "Rock":
            beatingMove = 1
            selectionBeatsDefault = selection == beatingMove
        case "Paper":
            beatingMove = 2
            selectionBeatsDefault = selection == beatingMove
        case "Scissors":
            beatingMove = 0
            selectionBeatsDefault = selection == beatingMove
        default:
            selectionBeatsDefault = false
            
        }
        
        evaluateSelection(selectionBeatsDefault)
    }
    
    func evaluateSelection(_ beatsDefault: Bool) {
        if shouldWin && beatsDefault || !shouldWin && !beatsDefault {
            score += 1
        } else {
            score -= 1
        }
        print(shouldWin && beatsDefault || !shouldWin && !beatsDefault)
        counter += 1
        
        if counter < 11 {
            // reset game after selection
            selectedMove = Int.random(in: 0..<3)
            shouldWin = Bool.random()
            
            if counter == 10 {
                showScore = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
