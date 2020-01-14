//
//  ContactsContainerView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


struct ContactsContainerView {
    @EnvironmentObject private var store: AppStore
    
    @ObservedObject var viewModel = ViewModel()
    
    @State private var isShowingScannerView = false
}


// MARK: - View
extension ContactsContainerView: View {

    var body: some View {
        NavigationView {
            VStack {
                filterPicker
                    .padding()
                
                contactsList
            }
            .navigationBarTitle("Collected Contacts")
            .navigationBarItems(trailing: addContactButton)
            .sheet(isPresented: $isShowingScannerView) {
                QRCodeScannerView(
                    simulatedData: "🚀 Rocket Man",
                    onScanCompleted: self.codeScanCompleted(_:)
                )
            }
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
            self.isShowingScannerView = true
        }) {
            Image(systemName: "qrcode.viewfinder")
                .imageScale(.large)
            Text("Scan")
        }
    }
}


// MARK: - Private Helpers
private extension ContactsContainerView {
    
    func codeScanCompleted(_ result: QRCodeScannerView.Completion) {
        switch result {
        case .success(let qrCodeString):
            createNewContact(from: qrCodeString)
//            self.store.send(ContactsSideEffect.createContact(qrCodeString))
        case .failure(let error):
            print("Scanning failed. Error \(error.localizedDescription)")
        }
    }
    
    
    func createNewContact(from qrCodeString: String) {
        let context = CurrentApp.coreDataManager.backgroundContext
        let contact = Contact.make(fromName: qrCodeString, using: context)

        self.store.send(ContactsSideEffect.save(contact))
    }
}



// MARK: - Preview
struct ContactsContainerView_Previews: PreviewProvider {

    static var previews: some View {
        ContactsContainerView(
            viewModel: .init()
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        .environmentObject(SampleData.appStore)
    }
}
