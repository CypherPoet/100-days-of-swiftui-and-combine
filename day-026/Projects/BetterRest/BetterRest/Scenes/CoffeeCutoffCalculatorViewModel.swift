//
//  CoffeeCutoffCalculatorViewModel.swift
//  BetterRest
//
//  Created by CypherPoet on 10/20/19.
// ✌️
//

import Foundation


final class CoffeeCutoffCalculatorViewModel: ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var calculatedCutoffTime: Date? = nil
    
    var alertTitle: String {
        "Coffee Cutoff Time"
    }
    
    var alertMessage: String {
        guard let formattedCutoffTime = formattedCutoffTime else { return "" }
        
        return """
        If you'd like to get enough sleep, you should stop drinking coffee \
        after \(formattedCutoffTime).
        """
    }
}


extension CoffeeCutoffCalculatorViewModel {
    
    private var formattedCutoffTime: String? {
        guard let cutoffTime = calculatedCutoffTime else { return nil }
        
        return DateFormatters.coffeeCutoffTime.string(from: cutoffTime)
    }
}
