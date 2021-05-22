//
//  ContentView.swift
//  iExpense
//
//  Created by Melo, Lareen on 5/21/21.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var secondName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", secondName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
