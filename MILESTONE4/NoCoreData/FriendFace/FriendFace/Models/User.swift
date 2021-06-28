//
//  User.swift
//  FriendFace
//
//  Created by Lareen Melo on 6/26/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let company: String
    
    // sugary tingz
    let isActive: Bool
    let email: String
    let address: String
    let about: String
    
    // grasita
    let friends: [Friend]
    
}
