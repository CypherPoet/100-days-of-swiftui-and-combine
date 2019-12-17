//
//  EditLocationView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/13/19.
// ✌️
//

import SwiftUI


struct EditLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: AppStore
    
    @ObservedObject private(set) var viewModel: EditLocationViewModel
    
    
    init(location: Location) {
        self.viewModel = EditLocationViewModel(location: location)
    }
}


// MARK: - Body
extension EditLocationView {

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Location Name", text: Binding($viewModel.location.title, "Untitled Location"))
                    //                    TextField("Description", text: Binding($viewModel.location.longDescription, ""))
                    TextField("Description", text: Binding($viewModel.location.longDescription, replacingNilWith: ""))
                }
                .padding(.bottom)
                
                
                Section(header: Text("Nearby Locations...").font(.headline)) {
                    if viewModel.wikiPagesFetchState == .fetching {
                        Text("Fetching...")
                    } else if viewModel.wikiPages.isEmpty {
                        Text("None Found")
                    } else {
                        List(viewModel.wikiPages) { page in
                            Text(page.title ?? "Untitled Page")
                        }
                    }
                }
            }
            .navigationBarTitle("Edit Location")
            .navigationBarItems(trailing: saveButton)
        }
        .onAppear {
            self.viewModel.store = self.store
            
            self.store.send(.wikiPages(.fetchStateSet(.fetching)))
            self.store.send(WikiPagesSideEffect.fetchPages(near: self.viewModel.location))
        }
    }
}


// MARK: - Computeds
extension EditLocationView {


}


// MARK: - View Variables
extension EditLocationView {

    private var saveButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
}



// MARK: - Preview
struct EditLocationView_Previews: PreviewProvider {

    static var previews: some View {
        EditLocationView(
            location: SampleData.Locations.santorini
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        .environmentObject(SampleData.SampleAppStore.default)
    }
}
