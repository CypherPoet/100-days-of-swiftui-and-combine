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
    @State private var isShowingSortingActionSheet = false
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
            .navigationBarItems(
                leading: changeSortingButton,
                trailing: addContactButton
            )
            .sheet(isPresented: $isShowingScannerView) {
                QRCodeScannerView(
                    simulatedData: "🚀 Rocket Man",
                    onScanCompleted: self.codeScanCompleted(_:)
                )
            }
            .actionSheet(isPresented: $isShowingSortingActionSheet) { self.sortingActionSheet }
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
        ContactsListView(
            viewModel: .init(
                filterState: viewModel.filterState
            ),
            filterState: viewModel.filterState,
            sortingState: viewModel.sortingState
        )
    }
    
    
    private var changeSortingButton: some View {
        Button(action: {
            self.isShowingSortingActionSheet = true
        }) {
            Image(systemName: "arrow.up.and.down")
                .imageScale(.large)
            Text("Sorting")
        }
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
    
    
    private var sortingActionSheet: ActionSheet {
        let actionButtons: [ActionSheet.Button] = Contact.SortingState.allCases.map { sortingState in
            .default(
                Text(sortingState.displayName),
                action: { self.viewModel.sortingState = sortingState }
            )
        }
        
        return ActionSheet(
            title: Text("Sort contacts in the list"),
            buttons: actionButtons + [.cancel()]
        )
    }
}


// MARK: - Private Helpers
private extension ContactsContainerView {
    
    func codeScanCompleted(_ result: QRCodeScannerView.Completion) {
        switch result {
        case .success(let qrCodeString):
            createNewContact(from: qrCodeString)
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
