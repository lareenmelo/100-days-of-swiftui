//
//  Habits.swift
//  HabitTracker
//
//  Created by Melo, Lareen on 5/30/21.
//

import Foundation

class Habits: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let activities = UserDefaults.standard.data(forKey: "habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
                return
            }
        }
        
        self.activities = []
    }
    
    func updateActivity(_ activity: Activity) {
        guard let index = self.activities.firstIndex(where: { $0.id == activity.id }) else { return }
        activities[index] = activity
        
    }
}
