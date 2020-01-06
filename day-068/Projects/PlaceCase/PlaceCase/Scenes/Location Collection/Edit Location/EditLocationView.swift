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
    
    @ObservedObject var viewModel: EditLocationViewModel
}


// MARK: - Body
extension EditLocationView {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details").font(.headline)) {
                    TextField(
                        "Location Name",
                        text: Binding($viewModel.location.title, "Untitled Location")
                    )
                    TextField(
                        "Description",
                        text: Binding($viewModel.location.longDescription, replacingNilWith: "")
                    )
                }
                
                
                Section(header: Text("Add A Photo").font(.headline)) {

                    Button(action: {
                        
                    }) {
                        Group {
//                            if viewModel.location.userPhoto != nil {
                            if false {
                            } else {
                                HStack {
                                    Spacer()
                                    
                                    VStack {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120)

                                        Text("No Photo Selected")
                                            .font(.title)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                
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
            viewModel: EditLocationViewModel(
                location: SampleData.Locations.santorini,
                wikiPagesState: SampleData.SampleAppStore.default.state.wikiPagesState
            )
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        .environmentObject(SampleData.SampleAppStore.default)
    }
}
