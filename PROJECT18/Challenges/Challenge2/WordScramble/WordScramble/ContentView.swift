//
//  ContentView.swift
//  WordScramble
//
//  Created by Melo, Lareen on 5/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    // 3
    private var score: Int {
        var count = 0
        for word in usedWords {
            count += word.count
        }
        return count
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                // D94 - challenge 2
                GeometryReader { geometry in
                    List(usedWords, id: \.self) { word in
                        // D94 - challenge 2
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(self.getColor(list: geometry, word: geo))     // D94 - challenge 3

                                Text(word)
                            }
                            .frame(width: geo.size.width, alignment: .leading)
                            .offset(x: self.getOffset(list: geometry, word: geo), y: 0)


                        }
                    }
                }
                
                // 3
                Text("Score: \(score)")
                    .font(.title2)
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(trailing: Button(action: newGame) { // 2
                Text("New Game")
            }
            )
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        // 1
        guard isNotStartWord(word: answer) else {
            wordError(title: "Word not possible", message: "Please use a word different from the original")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        // 1
        guard word.count >= 3 else { return false }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    // 1
    func isNotStartWord(word: String) -> Bool {
        word != rootWord
    }
    
    // 2
    func newGame() {
        usedWords = [String]()
        newWord = ""
        startGame()
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
    }
    
    // D94 - challenge 2
    func getOffset(list: GeometryProxy, word: GeometryProxy) -> CGFloat {
        let listHeight = list.size.height
        let listStart = list.frame(in: .global).minY
        let itemStart = word.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        let thresholdPercent: CGFloat = 60
        let indent: CGFloat = 9

        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }

        return 0
    }
    // D94 - challenge 3
    func getColor(list: GeometryProxy, word: GeometryProxy) -> Color {
        let listHeight = list.size.height
        let listStart = list.frame(in: .global).minY
        let wordStart = word.frame(in: .global).minY
        
        let percent = (wordStart - listStart) / listHeight * 100

        let color = Double(percent / 100)

        return Color(red: 2 * color, green: 2 * (1 - color), blue: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
