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
    }
}


// MARK: - View
extension ContactsListView.ListItem: View {
        var body: some View {
            HStack {
                Text(contact.name)
            }
            .contextMenu {
                Button(action: {
                    self.toggleStatus()
                }) {
                    Text("Mark \(self.contact.status == .contacted ? "Uncontacted" : "Contacted")")
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
