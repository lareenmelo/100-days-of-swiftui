//
//  AddActivity.swift
//  HabitTracker
//
//  Created by Melo, Lareen on 5/30/21.
//

import SwiftUI

struct AddActivity: View {
    @State private var title = ""
    @State private var description = ""
    @ObservedObject var habits: Habits

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)

            }
            .navigationBarTitle("Add activity")
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(title: title, description: description)
                self.habits.activities.append(activity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(habits: Habits())
    }
}
