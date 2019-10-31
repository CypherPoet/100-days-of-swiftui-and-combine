//
//  ExpenseItem.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import Foundation



struct ExpenseItem: Identifiable {
    let id = UUID()
    
    let name: String
    let category: ExpenseItem.Category
    let satoshis: Double
}


extension ExpenseItem: Codable {}
