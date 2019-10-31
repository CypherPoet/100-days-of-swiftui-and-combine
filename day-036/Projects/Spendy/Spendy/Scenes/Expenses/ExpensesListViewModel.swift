//
//  ExpensesListViewModel.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import SwiftUI
import Combine
import UserDefault


final class ExpensesListViewModel: ObservableObject {
    
    @UserDefault("saved-expense-data", defaultValue: Data())
    var savedExpenseData: Data

    
    @Published var expenses: [ExpenseItem] = [] {
        didSet { saveExpenseData() }
    }

    
    init(expenses: [ExpenseItem] = []) {
        self.expenses = expenses
    }
    
    
    init() {
//        self.expenses = loadSavedExpenses()
        self.expenses = SampleExpenses.default
    }
}


// MARK: - Persistence Helpers

// 📝 Ideally, this wouldn't be done in the view model -- we'd have a separate state manager
// that could be called upon to handle this.
extension ExpensesListViewModel {
    
    func loadSavedExpenses() -> [ExpenseItem] {
        let decoder = JSONDecoder()
        
        return (try? decoder.decode([ExpenseItem].self, from: savedExpenseData)) ?? []
    }
    
    
    func saveExpenseData() {
        let encoder = JSONEncoder()
        
        savedExpenseData = (try? encoder.encode(expenses)) ?? Data()
    }
}
