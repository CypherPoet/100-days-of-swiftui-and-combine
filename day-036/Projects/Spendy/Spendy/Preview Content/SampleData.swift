//
//  SampleData.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

#if DEBUG

import Foundation


enum SampleExpenses {
    static let `default` = [
        ExpenseItem(name: "Coffee", category: .coffee, satoshis: 1_120.49),
        ExpenseItem(name: "16-inch MacBook Pro", category: .tools, satoshis: 50_000_000),
        ExpenseItem(name: "Bone-in Ribeye", category: .food, satoshis: 20_000),
    ]
}


enum SampleExpensesListViewModel {
    static let `default` = ExpensesListViewModel(expenses: SampleExpenses.default)
}

#endif
