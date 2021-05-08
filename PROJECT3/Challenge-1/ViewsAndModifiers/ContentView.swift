//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Melo, Lareen on 5/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Custom Title")
                .largeFont() // 1
            Spacer()
        }
    }
}

// 1
struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

// 1
extension View {
    func largeFont() -> some View {
        self.modifier(BlueTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
