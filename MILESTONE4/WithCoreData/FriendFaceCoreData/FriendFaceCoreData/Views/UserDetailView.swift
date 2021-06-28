//
//  UserDetailView.swift
//  FriendFaceCoreData
//
//  Created by Lareen Melo on 6/27/21.
//

import SwiftUI

struct UserDetailView: View {
    var person: User

    var body: some View {
        VStack {
            Text(person.userName)
            Text("Status: \(person.isActive ? "Online" : "Offline")")
            Text("Age: \(person.age)")
            Text("Works at \(person.userCompany)")
            Text(person.userEmail)
            Text(person.userAbout)
            VStack {
                Spacer()
                Text("\(person.userName)'s friends")
                List {
                    // Friends
                    ForEach(person.friendsList, id: \.id) { friend in
                        NavigationLink(destination: UserDetailView(person: friend)) {
                            Text(friend.userName)
                            
                        }
                    }
                }
            }
        }
    }
}
