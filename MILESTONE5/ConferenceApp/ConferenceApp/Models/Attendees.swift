//
//  Attendees.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/15/21.
//

import Foundation

class Attendees: ObservableObject {
    @Published var attendeesList = [Person]() {
        didSet {
            do {
                let filename = getDocumentsDirectory().appendingPathComponent("SavedContacts")
                let data = try JSONEncoder().encode(self.attendeesList)
                try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    init() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedContacts")
        
        do {
            let data = try Data(contentsOf: filename)
            if let list = try? JSONDecoder().decode([Person].self, from: data) {
                self.attendeesList = list
            } else {
                self.attendeesList = []
            }
            
            return
            
        } catch {
            print("Unable to load saved contacts")
        }
    }
}
