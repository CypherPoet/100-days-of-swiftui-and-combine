//
//  CoffeeCutoffCalculator.swift
//  BetterRest
//
//  Created by CypherPoet on 10/19/19.
// ✌️
//

import SwiftUI
import Foundation


struct CoffeeCutoffCalculator: View {
    @ObservedObject private var viewModel = CoffeeCutoffCalculatorViewModel()
}
 

// MARK: - Body
extension CoffeeCutoffCalculator {
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 24.0) {
                CoffeeCutoffNotice(cutoffTime: viewModel.calculatedCutoffTime)
                
                Form {
                    wakeUpTimeSection
                    sleepTargetSection
                    coffeeTargetSection
                }
                
                Spacer()
            }
            .navigationBarTitle("BetterRest", displayMode: .large)
        }
    }
}


// MARK: - View Variables
extension CoffeeCutoffCalculator {
    
    private var wakeUpTimeSection: some View {
        Section(
            header:
                Text("When would you like to wake up?")
                    .font(.headline)
        ) {

            DatePicker(
                "Desired Wake Up Time",
                selection: $viewModel.desiredWakeup,
                in: Date()...,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
        }
    }
    
    
    private var coffeeTargetSection: some View {
        Section(
            header:
                Text("☕️ Coffee Target")
                    .font(.headline)
        ) {
            VStack {
                Slider(
                    value: $viewModel.desiredCoffeeAmount,
                    in: 0...20,
                    minimumValueLabel: Text("0"),
                    maximumValueLabel: Text("20"),
                    label: { Text("Desired 8-ounce cups of coffee") }
                )
    
                Text(viewModel.formattedDesiredCoffeeAmount)
            }
        }
    }

    
    private var sleepTargetSection: some View {
        Section(
            header:
                Text("🛌 Sleep Target (Hours)")
                    .font(.headline)
        ) {
            Stepper(
                value: $viewModel.desiredSleepAmount,
                in: 1...16,
                step: 0.25,
                label: { Text(viewModel.formattedDesiredSleepAmount) }
            )
            .accessibility(label: Text("Hours of desired sleep"))
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeCutoffCalculator()
    }
}
