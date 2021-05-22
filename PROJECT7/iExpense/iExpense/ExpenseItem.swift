//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Melo, Lareen on 5/21/21.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
