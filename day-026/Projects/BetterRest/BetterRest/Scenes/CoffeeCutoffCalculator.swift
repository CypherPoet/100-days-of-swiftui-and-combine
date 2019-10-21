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
    typealias Hours = Double
    typealias Cups = Double
    
    @State private var desiredSleepAmount: Hours = 7.5
    @State private var desiredWakeup = Date.defaultWakeUp()
    @State private var desiredCoffeeAmount: Cups = 5

    @ObservedObject private var viewModel = CoffeeCutoffCalculatorViewModel()
    
    private let sleepAmountFormatter = NumberFormatters.sleepAmount
    private let coffeeAmountFormatter = NumberFormatters.coffeeAmount
}
 

// MARK: - Body
extension CoffeeCutoffCalculator {
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("Coffee Cut-Off Calculator")
                    .padding(.leading, 20)
                    .font(.subheadline)
                
                Form {
                    wakeUpTimeSection
                    sleepTargetSection
                    coffeeTargetSection
                }
                .navigationBarTitle("BetterRest")
                .navigationBarItems(trailing: navbarCalculationButton)
            }
            .alert(isPresented: $viewModel.isShowingAlert) {
                calculationAlert
            }
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
                selection: $desiredWakeup,
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
            Stepper(
                value: $desiredCoffeeAmount,
                in: 0...20,
                step: 0.5
            ) {
                Text(
                    "\(coffeeAmountFormatter.string(from: desiredCoffeeAmount as! NSNumber)!)" +
                    " Cups"
                )
            }
            .accessibility(label: Text("Cups of desired coffee"))
        }
    }

    
    private var sleepTargetSection: some View {
        Section(
            header:
                Text("🛌 Sleep Target (Hours)")
                    .font(.headline)
        ) {
            Stepper(
                value: $desiredSleepAmount,
                in: 1...16,
                step: 0.25
            ) {
                Text(
                    "\(sleepAmountFormatter.string(from: desiredSleepAmount as! NSNumber)!)" +
                    " Hours"
                )
            }
            .accessibility(label: Text("Hours of desired sleep"))
        }
    }
    
    
    private var navbarCalculationButton: some View {
        Button(action: calculateCutoffTime) {
            Text("Calculate")
        }
    }
    
    
    private var calculationAlert: Alert {
        Alert(
            title: Text(viewModel.alertTitle),
            message: Text(viewModel.alertMessage),
            dismissButton: .default(Text("👌 OK"))
        )
    }
}


// MARK: - Private Helpers
extension CoffeeCutoffCalculator {

    func calculateCutoffTime() {
        let secondsSinceMidnight = desiredWakeup.secondsSinceMidnight

        do {
            let prediction = try SleepCalculator().prediction(
                wake: secondsSinceMidnight,
                estimatedSleep: desiredSleepAmount,
                coffee: desiredCoffeeAmount
            )

            let sleepTimePlusCoffeeCutoffTime = prediction.actualSleep
            
            viewModel.calculatedCutoffTime = desiredWakeup - sleepTimePlusCoffeeCutoffTime
            viewModel.isShowingAlert = true
        } catch {
            fatalError("CoreML prediction failure: \(error.localizedDescription)")
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeCutoffCalculator()
    }
}
