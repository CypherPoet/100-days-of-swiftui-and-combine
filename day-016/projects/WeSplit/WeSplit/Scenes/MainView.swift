//
//  MainView.swift
//  WeSplit
//
//  Created by Brian Sipple on 10/8/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var checkAmountString: String = ""
    @State private var numberOfPeople = 1
    @State private var tipPercentage = TipPercentageChoice.zero
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Total Check Amount", text: $checkAmountString)
                            .keyboardType(.numberPad)
                        
                        Picker("Number of People", selection: $numberOfPeople) {
                            ForEach(1...100, id: \.self) { number in
                                Text("\(number) \(number == 1 ? "Person" : "People")")
                            }
                        }
                    }
                    
                    Section(header: Text("How much would you like to tip?")) {
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(TipPercentageChoice.allCases, id: \.self) { percentage in
                                    Text("\(percentage.rawValue)%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    if formattedAmountPerPerson != nil {
                        Section(
                            header: HStack {
                                Spacer()
                                Text("Your Split")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.pink)
                                    .padding(.top, 64)
                                    .padding(.bottom, 8)
                                Spacer()
                            }
                        ) {
                            Text("\(formattedAmountPerPerson!) Satoshis")
                        }
                    }
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}


extension MainView {
     private var checkAmount: Double { Double(checkAmountString) ?? 0 }
     
     
    private var totalCost: Double {
         checkAmount
             + (checkAmount * (Double(tipPercentage.rawValue) / 100.0))
     }
     

    private var amountPerPerson: Double? {
         guard numberOfPeople > 0 else { return nil }

         return totalCost / Double(numberOfPeople)
     }
    
    
    private var formattedAmountPerPerson: String? {
         guard let amountPerPerson = amountPerPerson else { return nil }
         
         return Currency.formatter.string(from: amountPerPerson as NSNumber)
     }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
