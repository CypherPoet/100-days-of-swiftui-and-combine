//
//  CountdownTimerView+ViewModel.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/21/20.
// ✌️
//

import Foundation


extension CountdownTimerView {
    final class ViewModel {
        var timeRemaining: TimeInterval
        

        // MARK: - Init
        init(
            timeRemaining: TimeInterval = 100.0
        ) {
            self.timeRemaining = timeRemaining
        }
    }
}


// MARK: - Publishers
extension CountdownTimerView.ViewModel {
}


// MARK: - Computeds
extension CountdownTimerView.ViewModel {
    var timeRemainingText: String {
        NumberFormatters.cardCountdown.string(for: timeRemaining) ?? ""
    }
}



// MARK: - Private Helpers
private extension CountdownTimerView.ViewModel {
}
