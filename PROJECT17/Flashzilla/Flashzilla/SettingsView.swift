//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Lareen Melo on 7/27/21.
//

// challenge 2
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var tryWrongCardsAgain: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("When you get a wrong answer that card goes back into the stack so you can try again :)")) {
                    Toggle(isOn: $tryWrongCardsAgain) {
                        Text("Try wrong cards again")
                    }
                    .onChange(of: tryWrongCardsAgain, perform: { value in
                        UserDefaults.standard.setValue(value, forKey: "tryAgain")
                    })
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tryWrongCardsAgain: Binding.constant(true))
    }
}
