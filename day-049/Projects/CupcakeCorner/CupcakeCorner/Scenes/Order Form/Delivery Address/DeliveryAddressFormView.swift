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
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Name", text: $viewModel.nameText)
                    
                    if viewModel.nameErrorMessage != nil {
                        Text(viewModel.nameErrorMessage!)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Street Address", text: $viewModel.streetAddressText)
                    
                    if viewModel.streetAddressErrorMessage != nil {
                        Text(viewModel.streetAddressErrorMessage!)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("City", text: $viewModel.cityText)
                    
                    if viewModel.cityErrorMessage != nil {
                        Text(viewModel.cityErrorMessage!)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Zip Code", text: $viewModel.zipCodeText)
                    
                    if viewModel.zipCodeErrorMessage != nil {
                        Text(viewModel.zipCodeErrorMessage!)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .transition(.move(edge: .bottom))
            
            
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
