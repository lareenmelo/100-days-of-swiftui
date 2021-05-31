//
//  ContentView.swift
//  HabitTracker
//
//  Created by Melo, Lareen on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var isPresentingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.activities) { activity in
                    NavigationLink(destination: ActivityDetailView(activity: activity, habits: habits)) {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .fontWeight(.medium)
                                .font(.title2)
                            HStack(spacing: 0) {
                                Text("You've completed this activity ")
                                Text("\(activity.completionCounter) ")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                                Text("times")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteActivities)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.isPresentingAddActivity = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
                                    .sheet(isPresented: $isPresentingAddActivity) {
                                        AddActivity(habits: habits)
                                    }
            )
        }
    }
    
    func deleteActivities(at offsets: IndexSet) {
        habits.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
