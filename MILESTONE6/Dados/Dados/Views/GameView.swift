//
//  GameView.swift
//  Dados
//
//  Created by Lareen Melo on 8/17/21.
//

import SwiftUI
import CoreData

struct GameView: View {
    @State private var dieNumber = Int.random(in: 1...6)
    @State private var isPaused = false
    @Environment(\.managedObjectContext) var moc
    
    let colors: [Color] = [.blue, .green, .orange, .pink, .purple, .red, .yellow]
    var body: some View {
        VStack(spacing: 64) {
            Spacer()
            Image("\(dieNumber)")
                .renderingMode(.template)
                .foregroundColor(colors[Int.random(in: 0..<colors.count)])
            
            Button(action: { self.rollDie() }, label: {
                HStack {
                    Image(systemName: "wave.3.left")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Image(systemName: "die.face.5.fill")
                        .font(.title)
                        .rotationEffect(.degrees(60))
                        .foregroundColor(.white)
                    Image(systemName: "wave.3.right")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
            })
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.blue)
            .cornerRadius(16)
            .disabled(isPaused == true)
            
            Spacer()
        }
    }
    
    private func generateNumbersList() -> [Int] {
        var numbersList = [Int]()
        
        for _ in 1...200 {
            numbersList.append(Int.random(in: 1...6))
        }
        
        return numbersList
    }
    
    func rollDie() {
        isPaused = true
        
        let numbersList = generateNumbersList()
        let duration = 3.75 / Double(numbersList.count)
        
        for index in 0..<numbersList.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(index)) {
                dieNumber = numbersList[index]
                
                if index == numbersList.count - 1 {
                    isPaused = false
                    
                    let newResult = Die(context: moc)
                    newResult.number = Int16(dieNumber)
                    newResult.date = Date()
                    try? self.moc.save()
                    
                }
            }
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
