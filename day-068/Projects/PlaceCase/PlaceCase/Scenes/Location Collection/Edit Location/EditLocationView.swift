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
    @ObservedObject var location: Location
}


// MARK: - Body
extension EditLocationView {

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Location Name", text: Binding($location.title, "Untitled Location"))
//                    TextField("Description", text: Binding($location.longDescription, ""))
                    TextField("Description", text: Binding($location.longDescription, replacingNilWith: ""))
                }
            }
            .navigationBarTitle("Edit Location")
            .navigationBarItems(trailing: saveButton)
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
    }
}
