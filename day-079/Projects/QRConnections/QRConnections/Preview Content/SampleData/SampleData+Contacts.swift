//
//  Contacts.swift
//  QRConnections
//
//  Created by CypherPoet on 1/10/20.
// ✌️
//

import Foundation
import CoreData


extension SampleData {
    static let contactUUIDs: [UUID] = [
        UUID(uuidString: "879da3b9-4f3b-459f-8b53-2e39908e1900")!,
        UUID(uuidString: "23bb3482-3655-4292-ae90-223c3ac6fa69")!,
        UUID(uuidString: "015505c4-2732-48e3-a697-0c45ec1a4ccf")!,
        UUID(uuidString: "c3edfa5c-3278-4f45-b86e-c272ba787a70")!,
        UUID(uuidString: "611132c1-2276-435d-b7fd-5e1f54e6f203")!,
    ]
//    static let contactUUIDStrings: [UUID] = [
//        "879da3b9-4f3b-459f-8b53-2e39908e1900",
//        "23bb3482-3655-4292-ae90-223c3ac6fa69",
//        "015505c4-2732-48e3-a697-0c45ec1a4ccf",
//        "c3edfa5c-3278-4f45-b86e-c272ba787a70",
//        "611132c1-2276-435d-b7fd-5e1f54e6f203",
//    ]
    
    static func makeContacts(in context: NSManagedObjectContext) -> [Contact] {
        contactUUIDs.enumerated().map { (index, uuid) in
            let contact = Contact(context: context)
//            let contactInfo = ContactInfo(context: context)
            
            contact.status = Contact.Status.allCases.randomElement()!
            contact.uuid = uuid
            contact.name = "Contact \(index + 1)"
            
//            contactInfo.uuid = uuid
//            contactInfo.name = "Contact \(index + 1)"
//            contactInfo.contact = contact
            
            return contact
        }
    }
}
