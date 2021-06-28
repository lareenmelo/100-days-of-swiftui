//
//  User+CoreDataProperties.swift
//  FriendFaceCoreData
//
//  Created by Lareen Melo on 6/27/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var friends: NSSet?
    
    public var userName: String {
        name ?? "Unknown name"
    }
    
    public var userCompany: String {
        company ?? "Unknown email"
    }
    
    public var userEmail: String {
        email ?? "Unknown email"
    }

    public var userAddress: String {
        address ?? "Unknown address"
    }
    
    public var userAbout: String {
        about ?? "Unknown address"
    }

    public var friendsList: [User] {
        let set = friends as? Set<User> ?? []

        return set.sorted { $0.userName < $1.userName }
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
