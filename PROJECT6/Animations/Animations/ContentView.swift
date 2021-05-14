//
//  ContentView.swift
//  Animations
//
//  Created by Melo, Lareen on 5/13/21.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingPurple = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingPurple.toggle()
                }
            }
            
            if isShowingPurple {
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
