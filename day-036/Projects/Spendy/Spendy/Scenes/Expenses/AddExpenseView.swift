//
//  AddExpenseView.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import SwiftUI


struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = AddExpenseViewModel()

    var save: ((ExpenseItem) -> Void)
}


// MARK: - Body
extension AddExpenseView {

    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Name"),
                    footer: Text(viewModel.nameErrorMessage ?? "")
                        .foregroundColor(.red)
                ) {
                    TextField("Expense Name", text: $viewModel.expenseName)
                }
                
                
                Section(header: Text("Category")) {
                    VStack(spacing: 14.0) {
                        Picker("Category", selection: $viewModel.category) {
                            ForEach(ExpenseItem.Category.allCases, id: \.self) { category in
                                Image(systemName: category.systemImageName)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text(viewModel.category.displayName)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                }
                
                
                Section(
                    header: Text("Amount"),
                    footer: Text(viewModel.satoshisErrorMessage ?? "")
                        .foregroundColor(.red)
                ) {
                    TextField("Amount of satoshis spent", text: $viewModel.amountText)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("New Expense")
            .navigationBarItems(trailing: saveButton)
        }
    }
}


// MARK: - View Variables
extension AddExpenseView {

    private var saveButton: some View {
        Button(action: {
            guard let newExpenseItem = self.viewModel.newExpenseItem else {
                preconditionFailure()
            }
            
            self.save(newExpenseItem)
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
        .disabled(!viewModel.isFormValid)
    }
}



// MARK: - Preview
struct AddExpenseView_Previews: PreviewProvider {

    static var previews: some View {
        AddExpenseView(save: { _ in })
    }
}
