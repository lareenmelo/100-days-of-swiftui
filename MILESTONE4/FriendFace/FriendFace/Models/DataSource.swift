//
//  DataSource.swift
//  FriendFace
//
//  Created by Lareen Melo on 6/26/21.
//

import Foundation

class DataSource: ObservableObject {
    @Published var users = [User]()
    
    init(users: [User]) {
        self.users = users
    }
    
    init() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    return
                }
            }
        }.resume()
    }
    
    func find(user id: UUID) -> User? {
        return users.first { $0.id == id }
    }
}
