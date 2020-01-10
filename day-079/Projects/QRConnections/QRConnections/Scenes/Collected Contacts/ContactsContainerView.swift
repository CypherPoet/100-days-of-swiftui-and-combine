//
//  ContactsContainerView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct ContactsContainerView: View {
    @ObservedObject var viewModel: ViewModel
}


// MARK: - Body
extension ContactsContainerView {

    var body: some View {

        NavigationView {
            VStack {
                filterPicker
                    .padding()
                
                contactsList
            }
            .navigationBarTitle("Collected Contacts")
            .navigationBarItems(trailing: addContactButton)
        }
    }
}


// MARK: - Computeds
extension ContactsContainerView {}


// MARK: - View Variables
extension ContactsContainerView {

    private var filterPicker: some View {
        Picker("Current Filter State", selection: $viewModel.filterState) {
            ForEach(Contact.FilterState.allCases) { filterState in
                Text(filterState.displayName).tag(filterState)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    
    private var contactsList: some View {
        ContactsListView(filterState: viewModel.filterState)
    }
    
    
    private var addContactButton: some View {
        Button(action: {
            
        }) {
            Image(systemName: "qrcode.viewfinder")
                .imageScale(.large)
            Text("Scan")
        }
    }
}


// MARK: - Preview
struct ContactsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        ContactsContainerView(
            viewModel: .init()
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
