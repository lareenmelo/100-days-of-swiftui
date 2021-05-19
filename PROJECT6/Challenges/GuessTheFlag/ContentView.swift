//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Melo, Lareen on 5/1/21.
//

import SwiftUI



// bug fix, users can play even after selecting an answer


/* LOSING STATE
 THE WINNING CARD APPEARS WITH A GREEN SHADE
 THE LOSING CARD APPEARS WITH A RED SHADE
 THE LOSING CARD SHAKES
 */



struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    // 1
    @State private var cardAnimations = [0.0, 0.0, 0.0]
    // 2
    @State private var selectedRightAnswer = false
    
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
                    Button(action: { //1
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1.5))
                            .shadow(color: .black, radius: 2)
                        
                        
                    } // 1
                    .rotation3DEffect(
                        .degrees(cardAnimations[number]),
                        axis: (x: 0.0, y: 1.0, z: 0.0))
                    .overlay( // 3
                        wrongAnswerState(number)
                            
                    )
                    .opacity(shouldBeOpaque(number) ? 0.25 : 1.0) // 2
                }
                
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.medium)
                // 1
                if !selectedRightAnswer && showingScore {
                    Text("\(scoreTitle)\n\(scoreMessage)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.medium)
                }
                
                // 3
                Button("Next") {
                    self.askQuestion()
                }
                .font(.title2)
                .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            // 2
            selectedRightAnswer = true
            // 1
            withAnimation {
                cardAnimations[number] += 360
            }
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That’s the flag of \(countries[number])"
            score -= 1
            // 2
            selectedRightAnswer = false
            
        }
        
        showingScore = true
    }
    
    // 2
    func shouldBeOpaque(_ number: Int) -> Bool {
        return number != correctAnswer && selectedRightAnswer
    }
    
    // 3
    func wrongAnswerState(_ number: Int) -> some View {
        if showingScore && (number == correctAnswer) && !selectedRightAnswer {
            return Color.green.clipShape(Capsule()).opacity(0.45)
            
        } else if !selectedRightAnswer && showingScore {
            return Color.red.clipShape(Capsule()).opacity(0.45)
            
        } else {
            return Color.red.clipShape(Capsule()).opacity(0.0)

        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // 1
        cardAnimations = [0.0, 0.0, 0.0]
        showingScore = false
        // 2
        selectedRightAnswer = false
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
