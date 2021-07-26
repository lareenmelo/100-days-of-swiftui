//
//  Card.swift
//  Flashzilla
//
//  Created by Lareen Melo on 7/24/21.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
