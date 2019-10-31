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
    
    // Ideally, we'd have a view-model ObservableObject publish these and handle
    // validation logic.
    @State private var expenseName: String = ""
    @State private var satoshis: Double? = nil
    @State private var category: ExpenseItem.Category = .coffee
    
    var save: ((ExpenseItem) -> Void)
}


// MARK: - Computeds
extension AddExpenseView {
    
    private var newExpenseItem: ExpenseItem {
        .init(name: expenseName, category: category, satoshis: satoshis ?? 0)
    }
}


// MARK: - Body
extension AddExpenseView {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Expense Name", text: $expenseName)
                }
                
                
                Section(header: Text("Category")) {
                    VStack(spacing: 14.0) {
                        Picker("Category", selection: $category) {
                            ForEach(ExpenseItem.Category.allCases, id: \.self) { category in
                                Image(systemName: category.systemImageName)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text(category.displayName)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                }
                
                
                Section(header: Text("Amount")) {
                    TextField("Amount of satoshis spent", value: $satoshis, formatter: NumberFormatters.satoshis)
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
            self.save(self.newExpenseItem)
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
}



// MARK: - Preview
struct AddExpenseView_Previews: PreviewProvider {

    static var previews: some View {
        AddExpenseView(save: { _ in })
    }
}
