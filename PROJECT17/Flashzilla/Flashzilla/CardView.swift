//
//  CardView.swift
//  Flashzilla
//
//  Created by Lareen Melo on 7/24/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    let card: Card

    var removal: ((_ isCorrect: Bool) -> Void)?

    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    // challenge 2
    let tryWrongCardsAgain: Bool = UserDefaults.standard.bool(forKey: "tryAgain")
    private var shouldResetPosition: Bool {
        offset.width < 0 && tryWrongCardsAgain
    }


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(backgroundColor(offset: offset)) // challenge 3

                )
                .shadow(radius: 10)

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { offset in
                    self.offset = offset.translation
                    self.feedback.prepare()
                }

                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                        } else {
                            self.feedback.notificationOccurred(.error)
                        }

                        // challenge 2
                        self.removal?(self.offset.width > 0)
                        
                        if self.shouldResetPosition {
                            self.isShowingAnswer = false
                            self.offset = .zero
                        }
                        
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    // challenge 3
    func backgroundColor(offset: CGSize) -> Color {
        if offset.width > 0 {
            return .green
        }

        if offset.width < 0 {
            return .red
        }

        return .white
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
