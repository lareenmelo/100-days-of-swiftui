//
//  ContentView.swift
//  Flashzilla
//
//  Created by Lareen Melo on 7/23/21.
//

import SwiftUI
import CoreHaptics // challenge 1

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    @State private var cards = [Card]()
    // challenge 2
    @State private var showingSheet = false
    
    @State private var timeRemaining = 100
    @State private var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // challenge 1
    @State private var engine: CHHapticEngine?
    
    // challenge 2
    @State private var tryWrongCardsAgain = UserDefaults.standard.bool(forKey: "tryAgain")
    @State private var sheet: SheetType = .editCards
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) {
                            // challenge 2
                            isCorrect in
                            if !isCorrect {
                                if self.tryWrongCardsAgain {
                                self.removeCard(at: index, restack: true)
                                    return
                                }
                            }
                                withAnimation {
                                    self.removeCard(at: index)
                                }
                            
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            // challenge 2
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.sheet = .settings
                        self.showingSheet = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    Spacer()

                }
                Spacer()

            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // challenge 2
                        self.sheet = .editCards
                        self.showingSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            // challenge
                            if self.tryWrongCardsAgain {
                                self.restackCard(at: self.cards.count - 1)
                                return
                            }
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.gameEnded() // challenge 1
            }
        }
        // challenge 2
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if self.sheet == .editCards {
                EditCards()
            } else if self.sheet == .settings {
                SettingsView(tryWrongCardsAgain: self.$tryWrongCardsAgain)
            }
        }
        .onAppear(perform: resetCards)
        .onAppear(perform: prepareHaptics) // challenge 1
    }
    
    // challenge 2
    func removeCard(at index: Int, restack: Bool = false) {
        if !restack {
            guard index >= 0 else { return }
            
            cards.remove(at: index)
            
            if cards.isEmpty {
                isActive = false
            }
        } else {
            self.restackCard(at: index)
        }
    }
    
    // chhallenge 2
    func restackCard(at index: Int) {
        guard index >= 0 else { return }
        
        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    // challenge 1
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func gameEnded() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

// challenge 2
enum SheetType {
    case editCards, settings
}
