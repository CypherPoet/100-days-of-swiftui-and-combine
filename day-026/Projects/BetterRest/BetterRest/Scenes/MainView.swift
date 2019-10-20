//
//  MainView.swift
//  BetterRest
//
//  Created by CypherPoet on 10/19/19.
// ✌️
//

import SwiftUI
import Foundation


struct MainView: View {
    typealias Hours = Double
    typealias Ounces = Double
    
    @State private var desiredSleepAmount: Hours = 7.5
    @State private var desiredWakeup = Date.defaultWakeUp()
    @State private var desiredCoffeeAmount: Ounces = 140.011
    
    private let sleepAmountFormatter = NumberFormatters.sleepAmount
    private let coffeeAmountFormatter = NumberFormatters.coffeeAmount
}
 


extension MainView {
    var body: some View {
        
//        form
        
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("Coffee Cut-Off Calculator")
                    .padding(.leading, 22)
                    .font(.subheadline)
                
                VStack(spacing: 32) {
                    wakeUpTimeSection
                    
                    sleepTargetSection
                    
                    coffeeTargetSection
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding()
                .navigationBarTitle("BetterRest")
                .navigationBarItems(trailing: navbarCalculationButton)
            }
        }
    }
}


extension MainView {
    
    private var form: some View {
        Form {
        
            Stepper(value: $desiredSleepAmount, in: 1...16, step: 0.25) {
                HStack {
                    Text("🎯 Sleep Target (Hours)")
                    Spacer()
                    Text(
                        NumberFormatters.sleepAmount.string(from: desiredSleepAmount as! NSNumber) ?? ""
                    )
                }
            }
            .accessibility(label: Text("Hours of desired sleep"))
            
            
            DatePicker(
                selection: $desiredWakeup,
                in: Date()...,
                displayedComponents: .hourAndMinute
            ) {
                Text("Desired Wake Up Time")
            }
        }
    }
    
    
    private var wakeUpTimeSection: some View {
        VStack {
            Text("When would you like to wake up?")
                .font(.headline)
            
            DatePicker(
                "Desired Wake Up Time",
                selection: $desiredWakeup,
                in: Date()...,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
        }
    }
    
    
    private var coffeeTargetSection: some View {
        VStack {
            Text("☕️ Coffee Target")
                .font(.headline)
            
            Stepper(
                value: $desiredCoffeeAmount,
                in: 0...200,
                step: 1
            ) {
                Text(
                    "\(coffeeAmountFormatter.string(from: desiredCoffeeAmount as! NSNumber)!)" +
                    " Ounces"
                )
            }
            .accessibility(label: Text("Ounces of desired coffee"))
        }
    }

    
    private var sleepTargetSection: some View {
        VStack {
            Text("🛌 Sleep Target (Hours)")
                .font(.headline)
            
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
        Button(action: {
            
        }) {
            Text("Calculate")
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
