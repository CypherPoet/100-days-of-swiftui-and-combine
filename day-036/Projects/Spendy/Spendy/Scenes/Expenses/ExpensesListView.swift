//
//  ExpensesListView.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import SwiftUI


struct ExpensesListView: View {
    @ObservedObject private(set) var viewModel: ExpensesListViewModel
    
    var onAddExpense: (() -> Void)
}


// MARK: - Body
extension ExpensesListView {

    var body: some View {
        List {
            ForEach(viewModel.expenses) { expenseItem in
                ExpenseListItemView(expenseItem: expenseItem)
            }
            .onDelete(perform: removeItems(at:))
        }
        .navigationBarItems(
            leading: EditButton(),
            trailing: addButton
        )
    }
}


// MARK: - View Variables
extension ExpensesListView {
    
    var addButton: some View {
        Button(action: onAddExpense) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
    }
}



// MARK: - Private Helpers
private extension ExpensesListView {
    
    func removeItems(at offsets: IndexSet) {
        viewModel.expenses.remove(atOffsets: offsets)
    }
}


// MARK: - Preview
struct ExpensesList_Previews: PreviewProvider {

    static var previews: some View {
        ExpensesListView(
            viewModel: SampleExpensesListViewModel.default,
            onAddExpense: {}
        )
        .accentColor(.pink)
    }
}
