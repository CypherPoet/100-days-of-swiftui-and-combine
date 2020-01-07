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
    
    @State private var isShowingImagePicker = false
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
                
                
                Section(header: Text("Custom Photo").font(.headline)) {
                    customPhotoField
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
        .sheet(isPresented: $isShowingImagePicker) {
            UIImagePickerWrapper(onSelect: self.userPhotoSelected(_:))
        }
    }
}


// MARK: - Computeds
extension EditLocationView {}



// MARK: - View Variables
extension EditLocationView {

    private var customPhotoField: some View {
        Button(action: {
            self.isShowingImagePicker = true
        }) {
            HStack {
                Group {
                    if viewModel.location.userPhoto != nil {
                        viewModel.location.userPhoto!
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                    } else {
                        Spacer()

                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)

                            Text("Add a Photo")
                                .font(.title)
                        }
                        Spacer()
                    }
                }
            }
            .frame(height: 200)
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
}


// MARK: - Private Helpers
private extension EditLocationView {
    
    func userPhotoSelected(_ uiImage: UIImage) {
        viewModel.location.userPhotoData = uiImage.pngData()
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
