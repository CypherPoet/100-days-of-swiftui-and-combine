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
    
    @State private var desiredSleepAmount: Hours = 7.5
    @State private var desiredWakeup = Date.defaultWakeUp()
}
 


extension MainView {
    var body: some View {
        
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
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
