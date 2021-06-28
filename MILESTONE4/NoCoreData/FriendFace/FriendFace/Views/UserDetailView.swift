//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Lareen Melo on 6/26/21.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @ObservedObject var usersList: DataSource
    
    var body: some View {
        VStack {
            Text(user.name)
            Text("Status: \(user.isActive ? "Online" : "Offline")")
            Text("Age: \(user.age)")
            Text("Works at \(user.company)")
            Text(user.email)
            Text(user.about)
            
            VStack {
                Text("\(user.name)'s friends")
                List {
                    // Friends
                    ForEach(user.friends) { friend in
                        NavigationLink(destination: UserFriendsDetail(userID: friend.id, usersList: usersList)) {
                            Text(friend.name)
                            
                        }
                    }
                }
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: UUID(), name: "SZA", age: 30, company: "DAWG ENTERTAINMENT", isActive: true, email: "SZA@gmail.com", address: "California or whatever", about: "I'm a fairy", friends: [Friend]())
        UserDetailView(user: user, usersList: DataSource())
    }
}


struct UserFriendsDetail: View {
    let userID: UUID
    @ObservedObject var usersList: DataSource
    
    var body: some View {
        if let user = usersList.find(user: userID) {
            return AnyView(FriendDetailView(friend: user))
            
        } else {
            return AnyView(Text("Oh no..."))
        }
    }
}

struct FriendDetailView: View {
    let friend: User
    
    var body: some View {
        Text(friend.name)
        Text("Status: \(friend.isActive ? "Online" : "Offline")")
        Text("Age: \(friend.age)")
        Text("Works at \(friend.company)")
        Text(friend.email)
        Text(friend.about)
    }
}

