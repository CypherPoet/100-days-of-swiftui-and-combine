//
//  Date+DefaultWakeUpTime.swift
//  BetterRest
//
//  Created by CypherPoet on 10/19/19.
// ✌️
//

import Foundation


extension Date {
    
    func sameTimeNextDay(
        inDirection direction: Calendar.SearchDirection = .forward,
        using calendar: Calendar = .current
    ) -> Date {
        let components = calendar.dateComponents(
            [.hour, .minute, .second, .nanosecond],
            from: self
        )
        
        return calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: direction
        )!
    }
    

    static var currentTimeTomorrow: Date { Date().sameTimeNextDay() }
    

    static func startOfDayTomorrow(using calendar: Calendar = .current) -> Date {
        Calendar.current.startOfDay(for: currentTimeTomorrow)
    }
    
    
    static var currentTimeYesterday: Date {
        Date().sameTimeNextDay(inDirection: .backward)
    }
    
    
    static func defaultWakeUp(using calendar: Calendar = .current) -> Date {
        let startOfTomorrow = startOfDayTomorrow(using: calendar)
        let components = DateComponents(hour: 2, minute: 30)
        
        return calendar.date(byAdding: components, to: startOfTomorrow)!
    }
}
