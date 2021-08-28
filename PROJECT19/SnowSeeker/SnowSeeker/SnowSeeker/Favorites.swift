//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Lareen Melo on 8/26/21.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    // 2
    init() {
        // load our saved data

        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decode = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decode
                return
            }
        }
        // still here? Use an empty array
        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    // 2
    func save() {
        // write out our data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.setValue(encoded, forKey: saveKey)
        }
    }
}
