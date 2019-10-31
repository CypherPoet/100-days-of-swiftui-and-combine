//
//  ExpensesListContainerView.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import SwiftUI


struct ExpensesListContainerView: View {
    var viewModel = ExpensesListViewModel()
    
    @State private var isShowingAddView = false
}


// MARK: - Body
extension ExpensesListContainerView {

    var body: some View {
        NavigationView {
            ExpensesListView(
                viewModel: viewModel,
                onAddExpense: { self.isShowingAddView = true }
            )
            .navigationBarTitle("Spendy")
        }
        .sheet(isPresented: $isShowingAddView) {
            AddExpenseView { expenseItem in
                self.viewModel.expenses.append(expenseItem)
            }
        }
    }
}


// MARK: - Preview
struct ExpensesListContainerView_Previews: PreviewProvider {

    static var previews: some View {
        ExpensesListContainerView(viewModel: SampleExpensesListViewModel.default)
            .accentColor(.pink)
    }
}
