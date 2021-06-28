//
//  LocalUser.swift
//  FriendFaceCoreData
//
//  Created by Lareen Melo on 6/27/21.
//

import Foundation

struct LocalUser: Codable, Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let company: String
    
    let isActive: Bool
    let email: String
    let address: String
    let about: String
    
    // grasita
    let friends: [LocalFriend]
    
}
