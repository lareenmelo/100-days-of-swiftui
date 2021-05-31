//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Melo, Lareen on 5/30/21.
//

import SwiftUI

struct ActivityDetailView: View {
    var activity: Activity
    @State private var completedPoint = 0
    @ObservedObject var habits: Habits
    @State private var progress: CGFloat = 0.05
    @State private var isCompleted = false

    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text(activity.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text(activity.description)
                    .font(.title)
            }
            Spacer()
            VStack(spacing: 16) {
                Text("Times completed")
                ZStack {
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.green)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(Animation.easeInOut(duration: 1.0))
                        .opacity(isCompleted ? 1.0 : 0.0)

                    Text("\(activity.completionCounter)")
                        .fontWeight(.heavy)
                        .font(.title)
                }
            }
            
            Spacer()
            
            Button(action: {
                self.isCompleted = true
                withAnimation {
                    while progress <= 1.0 {
                        progress += 0.20
                    }
                }
                self.updateActivity()
            }, label: {
                Text("Complete activity")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.white)
            })
            .frame(width: 200, height: 45)
            .background(Color.blue)
            .cornerRadius(8.0)
            
            Spacer()
        }
        .padding()
        
    }
    
    func updateActivity() {
        var activity = self.activity
        activity.completionCounter += 1
        habits.updateActivity(activity)
        
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(title: "Test", description: "tested")

        ActivityDetailView(activity: activity, habits: Habits())
    }
}
