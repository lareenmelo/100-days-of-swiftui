//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Melo, Lareen on 5/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    // 3
    @State private var scoreMessage = ""
    @State private var score = 0 // 1

    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                            .shadow(color: .black, radius: 2)


                    }
                }
                
                // 2
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.medium)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            // 3
            scoreMessage = "That's the flag of \(countries[number])"
            score += 1 // 1
        } else {
            scoreTitle = "Wrong"
            // 3
            scoreMessage = "That’s the flag of \(countries[number])"
            score -= 1 // 1

        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
