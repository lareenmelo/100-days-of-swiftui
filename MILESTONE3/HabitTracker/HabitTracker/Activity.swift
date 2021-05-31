//
//  Activity.swift
//  HabitTracker
//
//  Created by Melo, Lareen on 5/30/21.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var completionCounter = 0
    
}
