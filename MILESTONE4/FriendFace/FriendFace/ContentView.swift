//
//  ContentView.swift
//  FriendFace
//
//  Created by Lareen Melo on 6/24/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var usersList = DataSource()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(usersList.users) { user in
                    NavigationLink(destination: UserDetailView(user: user, usersList: usersList)) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 8) {
                                Text(user.name)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text("\(user.age) yrs")
                                    .fontWeight(.medium)
                                    .font(.italic(.headline)())
                            }
                            Text(user.company)
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Friendsbook")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
