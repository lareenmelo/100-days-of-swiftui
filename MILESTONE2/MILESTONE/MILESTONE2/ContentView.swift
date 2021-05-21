//
//  ContentView.swift
//  MILESTONE2
//
//  Created by Melo, Lareen on 5/19/21.
//

import SwiftUI

struct Question {
    var a: Int
    var b: Int
    var answer: Int
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
        answer = self.a * self.b
    }
}


struct Game: View {
    // Keyboard properties
    @State private var currentKeySelection = ""
    private let keyboardKeys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "Delete", "0", "Submit"]
    private let keyboardGridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private let keyColors = [Color.blue, Color.orange, Color.pink, Color.purple, Color.yellow]
    private let keyboardColors = [Color.purple, Color.green, Color.pink, Color.purple, Color.yellow, Color.red, Color.yellow, Color.pink, Color.orange, Color.blue]

    
    // Game logic
    @State var questions = [Question]()
    let questionsCount: Int
    @State private var answer = ""
    @State private var endGame = false
    @Binding var ended: Bool
    @State private var score = 0
    @State private var message = ""

    var currentQuestion: Question {
        return Question(a: questions[0].a, b: questions[0].b)
    }
    
    // Results animation
    @State private var expand = false
    
    var body: some View {
        VStack {
            Text("\(score)/\(questionsCount)")
                .font(.title)
                .fontWeight(.bold)
            
            if !endGame {
                VStack {
                    Spacer()
                    HStack(alignment: .center, spacing: 64) {
                        Text("\(currentQuestion.a)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                        Text("x")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.purple)
                        Text("\(currentQuestion.b)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.pink)
                    }
                    
                    Spacer()
                    
                    Text("\(message)!!")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(message == "Correct" ? .green : .red)
                        .opacity(expand ? 1 : 0)
                        .offset(x: 0, y: expand ? -100 : -75)
                        .transition(.opacity)
                    
                    Text(answer)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(keyColors[Int.random(in: 0..<keyColors.count)])
                        .frame(minHeight: 50, alignment: .center)

                    
                    LazyVGrid(columns: keyboardGridLayout, alignment: .center, spacing: 8, content: {
                        ForEach(keyboardKeys, id: \.self) { number in
                            Button(action: {
                                self.handleKeys(number)

                            }, label: {
                                Text("\(number)")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .fontWeight(.black)
                            })
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            .background(setKeyColor(number))
                            .cornerRadius(10)
                        }
                    })
                    .padding(.all, 8)
                }
            } else {
                VStack(spacing: 16) {
                    Text("Session ended!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        
                    Button(action: {
                        self.ended.toggle()
                    }, label: {
                        Text("NEW SESSION")
                            .fontWeight(.heavy)
                            .font(.title2)
                            .foregroundColor(.white)
                        
                    })
                    .frame(width: 200, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(15.0)
                }
            }
        }
    }
    
    func handleKeys(_ key: String) {
        self.expand = false

        switch key {
        case "Submit":
            if !endGame {
                verifyAnswer()
            }
            submitAnswer()

        case "Delete":
            if answer.count > 0 {
                answer.removeLast()
            }
        default:
            answer += key
        }
        
    }
    
    func setKeyColor(_ key: String) -> Color {
        let number = Int(key) ?? 0
        switch key {
        case "Delete":
            return .red
        case "Submit":
            return .green
        default:
            return keyboardColors[number]
        }
    }
    
    
    
    func submitAnswer() {
        if questions.count >= 1 {
            questions.remove(at: 0)
            if questions.count == 0
            {
                endGame = true
            }
        }
    }
    
    func verifyAnswer() {
        let finalAnswer = Int(answer) ?? 0
        if finalAnswer == currentQuestion.answer {
            score += 1
            message = "Correct"
            
        } else {
            message = "Incorrect"
        }
        
        withAnimation(Animation.linear(duration: 1)) {
            self.expand.toggle()
        }

        answer = ""
    }
}

struct GameConfiguration:  View {
    @Binding var tableLimit: Int
    @Binding var questionsAmount: Int
    @State var questionsAmounts: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text("Tables up to...").foregroundColor(.blue).font(.title).fontWeight(.heavy)) {
                Stepper(value: $tableLimit, in: 1...12, step: 1) {
                    Text("\(tableLimit)")
                }
            }
            
            Section(header: Text("Select how many questions you want").foregroundColor(.green).font(.title).fontWeight(.heavy)) {
                Picker("How many questions?", selection: $questionsAmount) {
                    ForEach(0..<questionsAmounts.count) {
                        if $0 == 3 {
                            Text("All")
                            
                        } else {
                            Text("\(questionsAmounts[$0])")
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var gameEnded = false
    
    @State private var limit = 1
    @State private var questionsAmount = 0
    @State private var questionsAmounts = [5, 10, 20, 0]
    @State private var list = [Question]()
    
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    if gameStarted && !gameEnded {
                        Game(questions: list, questionsCount: questionsAmounts[questionsAmount], ended: $gameEnded)
                        
                    } else {
                        Image("giraffe")
                        GameConfiguration(tableLimit: $limit, questionsAmount: self.$questionsAmount, questionsAmounts: self.questionsAmounts)
                        Button(action: {
                            self.createQuestions(questionsAmounts[questionsAmount], upTo: limit)
                            self.gameStarted = true
                        }, label: {
                            Text("STAR TRAINING")
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                        .frame(width: 200, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(15.0)
                    }
                }
            }
        }
    }
    
    // FIXME: Find the proper place to store this table and questions creation
    // MARK: Questions Set Up
    /// Creates and returns a complete table from 1 x 1 to limit x limit
    private func createTable(_ limit: Int) -> [Question] {
        var list = [Question]()
        
        for a in 1...limit {
            for b in 1...12 {
                let q = Question(a: a, b: b)
                list.append(q)
            }
        }
        return list
    }
    
    func createQuestions(_ questions: Int, upTo limit: Int) {
        var questionsList = [Question]()
        var completeList = [Question]()
        
        completeList = createTable(limit)
        
        let amount = questions == 0 ? completeList.count : questions
        
        // FIXME: IF YOU CHOOSE 20 QUESTIONS AND YOU ONLY WANT TO REVIEW 1 TABLA (AKA 12 NUMBERS) THIS APP WILL CRASH
        for _ in 1...amount {
            completeList.shuffle()
            let randomIndex = Int.random(in: 0..<completeList.count)
            questionsList.append(completeList[randomIndex])
            completeList.remove(at: randomIndex) // remove to prevent repeated questions
        }
        
        list = questionsList
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
