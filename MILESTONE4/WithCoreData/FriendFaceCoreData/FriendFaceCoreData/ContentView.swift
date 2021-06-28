//
//  ContentView.swift
//  FriendFaceCoreData
//
//  Created by Lareen Melo on 6/27/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { person in
                    NavigationLink(destination: UserDetailView(person: person)) {
                            VStack(alignment: .leading) {
                                HStack(spacing: 8) {
                                    Text(person.userName)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                    Text("\(person.age) yrs")
                                        .fontWeight(.medium)
                                        .font(.italic(.headline)())
                                }
                                Text(person.userCompany)
                        }
                    }
                }
            }
            .navigationBarTitle("Friendsbook")
        }
        .onAppear(perform: checkDataLoad)
    }

    func checkDataLoad() {
        if users.isEmpty {
            DataSource.loadData(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
