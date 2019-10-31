//
//  ExpenseListItemView.swift
//  Spendy
//
//  Created by CypherPoet on 10/31/19.
// ✌️
//

import SwiftUI


struct ExpenseListItemView: View {
    let expenseItem: ExpenseItem
}


// MARK: - Body
extension ExpenseListItemView {

    var body: some View {
        HStack {
            Image(systemName: expenseItem.category.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 27, height: 27)
                .padding(13)
                .background(expenseItem.category.iconColor)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(expenseItem.name)")
                    .font(.headline)
                
                Text(expenseItem.category.displayName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(expenseItem.category.iconColor)
                    .saturation(0.9)
            }
            
            Spacer()
            
            Text("\(NumberFormatters.satoshis.string(from: expenseItem.satoshis as NSNumber) ?? "") sat")
                .foregroundColor(Color.secondary)
                .fontWeight(.semibold)
        }
    }
}


// MARK: - View Variables
extension ExpenseListItemView {

}



// MARK: - Preview
struct ExpenseListItemView_Previews: PreviewProvider {

    static var previews: some View {
        ExpenseListItemView(expenseItem: SampleExpenses.default[0])
    }
}
