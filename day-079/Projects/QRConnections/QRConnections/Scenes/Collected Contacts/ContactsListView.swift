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

