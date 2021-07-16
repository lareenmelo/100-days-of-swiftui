//
//  Person.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/14/21.
//

import SwiftUI

struct Person: Identifiable, Codable {
    var id = UUID()
    var name: String
    var image: String?
    var twitterHandle: String
    
    // Day 78
    var locationRecorded = false
    var latitude: Double = 0
    var longitude: Double = 0
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    mutating func setImage(image: Data) {
        self.image = setImage(image: image)
    }
    
    private func setImage(image: Data) -> String? {
        let url = getDocumentsDirectory().appendingPathComponent(UUID().uuidString)
        
        do {
            try image.write(to: url, options: [.atomicWrite, .completeFileProtection])
            return url.lastPathComponent
        } catch let error {
            print("Could not write image: " + error.localizedDescription)
        }
        
        return nil
        
    }
    
    func getImage() -> Data? {
        return getImage(imagePath: image)
    }
    
    private func getImage(imagePath: String?) -> Data? {
        guard let imagePath = imagePath else { return nil }

        // a cache system might be useful here, instead of loading every time from disk
        let url = getDocumentsDirectory().appendingPathComponent(imagePath)
        if let data = try? Data(contentsOf: url) {
            return data
        }

        return nil
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
