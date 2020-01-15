//
//  ContactsListView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct ContactsListView: View {
    private let fetchRequest: FetchRequest<Contact>
    
    init(filterState: Contact.FilterState) {
        self.fetchRequest = FetchRequest(fetchRequest: Contact.fetchRequest(for: filterState))
    }
}



// MARK: - Body
extension ContactsListView {

    var body: some View {
        List(contacts, rowContent: ListItem.init)
    }
}


// MARK: - Computeds
extension ContactsListView {
    var contacts: FetchedResults<Contact> { fetchRequest.wrappedValue }
}


// MARK: - View Variables
extension ContactsListView {}


// MARK: - List Item
extension ContactsListView {
    
    struct ListItem: View {
        // ⚠️ TODO: Clean up other guesses since this is what we need here
        @ObservedObject var contact: Contact
        
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
        
        
        func toggleStatus() {
            guard let context = contact.managedObjectContext else { fatalError() }

            contact.status = (contact.status == .contacted) ? .uncontacted : .contacted
            CurrentApp.coreDataManager.save(context)
        }
    }
}




// MARK: - Preview
struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        let managedObjectContext = CurrentApp.coreDataManager.mainContext
        SampleData.makeContacts(in: managedObjectContext)
        
        try? managedObjectContext.save()
        
        return Group {
            ContactsListView(filterState: .contacted)
                .environment(\.managedObjectContext, managedObjectContext)
        
            PreviewDevice.ApplicationSupportText()
        }
    }
}

