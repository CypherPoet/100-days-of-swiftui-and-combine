//
//  ContactsListView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct ContactsListView {
    private let fetchRequest: FetchRequest<Contact>
    
    @ObservedObject var viewModel: ViewModel
    
    
    init(
        viewModel: ViewModel = .init(),
        filterState: Contact.FilterState
    ) {
        self.viewModel = viewModel
        self.fetchRequest = FetchRequest(fetchRequest: Contact.fetchRequest(for: filterState))
    }
}



// MARK: - View
extension ContactsListView: View {

    var body: some View {
        List(contacts) { contact in
            ListItem(
                contact: contact,
                isShowingStatusIndicator: self.viewModel.shouldShowContactStatusIndicator,
                onScheduleNotification: self.scheduleNotification(for:)
            )
        }
    }
}


// MARK: - Computeds
extension ContactsListView {
    var contacts: FetchedResults<Contact> { fetchRequest.wrappedValue }
}


// MARK: - View Variables
extension ContactsListView {}


// MARK: - Private Helpers
private extension ContactsListView {
    
    func scheduleNotification(for contact: Contact) {
        viewModel.scheduleNotification(for: contact)
    }
}




// MARK: - Preview
struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        let managedObjectContext = CurrentApp.coreDataManager.mainContext
        SampleData.makeContacts(in: managedObjectContext)
        
        try? managedObjectContext.save()
        
        return Group {
            ContactsListView(
                viewModel: .init(filterState: .all),
                filterState: .all
            )
                .environment(\.managedObjectContext, managedObjectContext)
        
            PreviewDevice.ApplicationSupportText()
        }
    }
}

