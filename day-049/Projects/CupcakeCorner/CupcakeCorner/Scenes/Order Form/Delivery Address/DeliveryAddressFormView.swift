//
//  DeliveryAddressFormView.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//

import SwiftUI


struct DeliveryAddressFormView<Destination: View>: View {
    @ObservedObject private(set) var viewModel: DeliveryAddressFormViewModel
    
    var buildDestination: (() -> Destination)
}


// MARK: - Body
extension DeliveryAddressFormView {

    var body: some View {
        Form {
            
            Section {
                TextField("Name", text: $viewModel.name)
                TextField("Street Address", text: $viewModel.streetAddress)
                TextField("City", text: $viewModel.city)
                TextField("Zip Code", text: $viewModel.zipCode)
            }
            
            Section {
                NavigationLink(destination: buildDestination()) {
                    Text("Continue to Checkout")
                }
            }
            .disabled(viewModel.isFormValid == false)
        }
        .navigationBarTitle("Delivery Address", displayMode: .inline)
    }
}


// MARK: - Computeds
extension DeliveryAddressFormView {


}


// MARK: - View Variables
extension DeliveryAddressFormView {


}



// MARK: - Preview
struct DeliveryAddressFormView_Previews: PreviewProvider {

    static var previews: some View {
        DeliveryAddressFormView(
            viewModel: DeliveryAddressFormViewModel(),
            buildDestination: { EmptyView() }
        )
    }
}
