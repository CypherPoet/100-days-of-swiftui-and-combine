//
//  LocalNotifications.swift
//  QRConnections
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import UserNotifications


enum LocalNotifications {
    case contactReminder(for: Contact, using: Calendar = .current)
    
    
    var request: UNNotificationRequest {
        .init(
            identifier: self.identifier,
            content: self.content,
            trigger: self.trigger
        )
    }


    var identifier: String {
        "Local Notification (\(UUID().uuidString))"
    }
    
    
    var content: UNNotificationContent {
        let content = UNMutableNotificationContent()

        switch self {
        case .contactReminder(let contact, _):
            content.title = "📌 Contact Reminder"
            content.body = "Remember to get in touch with \(contact.name)."
            content.sound = .default
        }
        
        return content
    }
    

    var trigger: UNNotificationTrigger {
        switch self {
        case .contactReminder(_, let calendar):
            //            let futureOffset = DateComponents(calendar: calendar, hour: 1)
            let futureOffset = DateComponents(calendar: calendar, second: 5)
            let reminderDate = calendar.date(byAdding: futureOffset, to: Date())
            
            let reminderDateComponents = calendar.dateComponents(
                [.second],
                from: reminderDate!
            )
                
            return UNCalendarNotificationTrigger(dateMatching: reminderDateComponents, repeats: false)
        }
    }
}
