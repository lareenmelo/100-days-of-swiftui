//
//  ContentView.swift
//  Drawing
//
//  Created by Melo, Lareen on 5/24/21.
//

import SwiftUI


// 1
struct Arrow: InsettableShape {
    // 2
    var insetAmount: CGFloat = 0
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // FIXME: ma'am, this is brute-force
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY / 1.5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 1.5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 45))
        path.addLine(to: CGPoint(x: rect.midX + 1, y: rect.midY / 1.65))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY / 1.5))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        return path
    }
    
    // 2
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ContentView: View {
    @State private var insetAmount: CGFloat = 5
    @State private var animationRotation = false
    private var arrayColors = [
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.red]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .leading, endPoint: .trailing),
        LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing)
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Tap the arrow's border!")
                .font(.title)
                .fontWeight(.medium)
            Spacer()
            Arrow(insetAmount: insetAmount)
                // 2
                .strokeBorder(arrayColors[Int.random(in: 0...6)], style: StrokeStyle(lineWidth: insetAmount, lineCap: .round, lineJoin: .round))
                .frame(width: 250, height: 150)
                .rotationEffect(.degrees(animationRotation ? Double.random(in: 1...360) : 0))
                .animation(.linear)
                // 2
                .onTapGesture {
                    self.animationRotation = false
                    withAnimation(Animation.easeIn(duration: 1)) {
                        self.insetAmount = CGFloat.random(in: 10...40)
                    }
                }
            Spacer()
            
            Button("Tap me!") {
                self.animationRotation.toggle()
            }
            .frame(width: 160, height: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10.0)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
