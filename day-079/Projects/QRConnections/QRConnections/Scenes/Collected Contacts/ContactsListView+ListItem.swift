//
//  ContactsListView+ListItem.swift
//  QRConnections
//
//  Created by CypherPoet on 1/15/20.
// ✌️
//

import SwiftUI


extension ContactsListView {
    struct ListItem {
        @ObservedObject var contact: Contact
        
        let onScheduleNotification: ((Contact) -> Void)
    }
}


// MARK: - View
extension ContactsListView.ListItem: View {
    var body: some View {
        HStack {
            Text(contact.name)
        }
        .contextMenu { self.contextMenu }
    }
}


// MARK: - View Variables
private extension ContactsListView.ListItem {
    
    var contextMenu: some View {
        VStack {
            Button(action: {
               self.toggleStatus()
            }) {
                Text("Mark \(self.contact.status == .contacted ? "Uncontacted" : "Contacted")")
                Image(systemName: "person.crop.circle.badge.\(self.contact.status == .contacted ? "xmark" : "checkmark")")
            }
            
            Button(action: {
                self.onScheduleNotification(self.contact)
            }) {
                Text("Schedule a Contact Reminder")
                Image(systemName: "pin").rotationEffect(.radians(.pi / 4))
            }
        }
    }
}


// MARK: - Private Helpers
private extension ContactsListView.ListItem {
        
    func toggleStatus() {
        guard let context = contact.managedObjectContext else { fatalError() }

        contact.status = (contact.status == .contacted) ? .uncontacted : .contacted
        CurrentApp.coreDataManager.save(context)
    }
}
