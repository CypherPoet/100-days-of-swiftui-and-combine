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
        
        let isShowingStatusIndicator: Bool
        let onScheduleNotification: ((Contact) -> Void)
    }
}



// MARK: - View
extension ContactsListView.ListItem: View {
    var body: some View {
        HStack {
            Text(contact.name)
            
            if isShowingStatusIndicator {
                Spacer()
                
                Image(systemName: contact.status.sfSymbolName)
                    .foregroundColor(contact.status == .contacted ? Color.green : Color.secondary)
            }
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
                Image(
                    systemName: self.contact.status == .contacted ?
                        Contact.Status.uncontacted.sfSymbolName
                        : Contact.Status.contacted.sfSymbolName
                )
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
