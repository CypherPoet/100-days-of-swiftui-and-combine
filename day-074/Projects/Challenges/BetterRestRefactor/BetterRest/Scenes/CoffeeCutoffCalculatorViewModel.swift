//
//  CoffeeCutoffCalculatorViewModel.swift
//  BetterRest
//
//  Created by CypherPoet on 10/20/19.
// ✌️
//

import Foundation
import Combine


final class CoffeeCutoffCalculatorViewModel: ObservableObject {
    typealias Hours = Double
    typealias Cups = Double
    
    @Published var desiredSleepAmount: Hours = 7.5
    @Published var desiredWakeup = Date.defaultWakeUp()
    @Published var desiredCoffeeAmount: Cups = 5
    
    @Published var calculatedCutoffTime = Date()
    
    private let sleepAmountFormatter = NumberFormatters.sleepAmount
    private let coffeeAmountFormatter = NumberFormatters.coffeeAmount
    
    private var cancellableSubscribers = Set<AnyCancellable>()
    
    
    init() {
        calculationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.calculatedCutoffTime, on: self)
            .store(in: &cancellableSubscribers)
    }
}


// MARK: - Publishers
extension CoffeeCutoffCalculatorViewModel {
    
    var calculationPublisher: AnyPublisher<Date, Never> {
        Publishers.CombineLatest3($desiredWakeup, $desiredCoffeeAmount, $desiredSleepAmount)
            .debounce(for: .seconds(0.4), scheduler: RunLoop.main)
            .map { (wakeUpTime, coffeeAmount, sleepAmount) in
                self.calculateCutoffTime(
                    wakeUpTime: wakeUpTime,
                    coffeeAmount: coffeeAmount,
                    sleepAmount: sleepAmount
                )
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Computeds
extension CoffeeCutoffCalculatorViewModel {
    
    var formattedCutoffTime: String? {
        DateFormatters.coffeeCutoffTime.string(from: calculatedCutoffTime)
    }
    
    
    var formattedDesiredCoffeeAmount: String {
        "\(coffeeAmountFormatter.string(from: desiredCoffeeAmount as! NSNumber)!)" +
        " Cups" +
        " (\(coffeeAmountFormatter.string(from: (5 * desiredCoffeeAmount) as! NSNumber)!)" +
        " ounces)"
    }
    
    
    var formattedDesiredSleepAmount: String {
        "\(sleepAmountFormatter.string(from: desiredSleepAmount as! NSNumber)!)" +
        " Hours"
    }
    
    
    var alertTitle: String { "Coffee Cutoff Time" }
    
    
    var alertMessage: String {
        guard let formattedCutoffTime = formattedCutoffTime else { return "" }
        
        return """
        If you'd like to get enough sleep, you should stop drinking coffee \
        after \(formattedCutoffTime).
        """
    }
}



// MARK: - Private Helpers
extension CoffeeCutoffCalculatorViewModel {
        
    func calculateCutoffTime(
        wakeUpTime: Date,
        coffeeAmount: Cups,
        sleepAmount: Hours
    ) -> Date {
        let secondsSinceMidnight = desiredWakeup.secondsSinceMidnight

        do {
            let prediction = try SleepCalculator().prediction(
                wake: secondsSinceMidnight,
                estimatedSleep: desiredSleepAmount,
                coffee: desiredCoffeeAmount
            )

            let sleepTimePlusCoffeeCutoffTime = prediction.actualSleep
            
            return desiredWakeup - sleepTimePlusCoffeeCutoffTime
        } catch {
            print("CoreML prediction failure: \(error.localizedDescription)")
            
            /// 📝 If, for some reason, we can't generate a prediction,
            /// an optimization (in lieu of better error handling) could be to "lie" with a default cut-off time.
            let defaultHours = 60 * 60 * 7.5
            
            return desiredWakeup - defaultHours
        }
    }
}
