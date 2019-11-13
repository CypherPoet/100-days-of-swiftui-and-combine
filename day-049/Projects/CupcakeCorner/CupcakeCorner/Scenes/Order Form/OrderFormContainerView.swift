//
//  OrderFormContainerView.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/12/19.
// ✌️
//

import SwiftUI


struct OrderFormContainerView: View {
    @EnvironmentObject var store: AppStore
    
    private var orderFormViewModel = OrderFormViewModel()
    private var deliveryAddressViewModel = DeliveryAddressFormViewModel()
}


// MARK: - Body
extension OrderFormContainerView {

    var body: some View {
        NavigationView {
            OrderFormView(
                viewModel: orderFormViewModel,
                buildDestination: {
                    DeliveryAddressFormView(
                        viewModel: self.deliveryAddressViewModel,
                        buildDestination: {
                            CheckoutView(
                                viewModel: CheckoutViewModel(order: self.orderFromFormData),
                                onSubmit: self.submitOrder(_:)
                            )
                        }
                    )
                }
            )
            .navigationBarTitle("🧁 Cupcake Corner")
        }
    }
}


// MARK: - Computeds
extension OrderFormContainerView {

    var orderFromFormData: Order {
        guard let cupcakeFlavor = orderFormViewModel.selectedFlavor else {
            preconditionFailure("Attempted to checkout without valid data")
        }
            
        return Order(
            cupcake: Cupcake(flavor: cupcakeFlavor),
            quantity: orderFormViewModel.cupcakeQuantity,
            preferences: .init(
                hasSpecialRequest: orderFormViewModel.hasSpecialRequest,
                wantsExtraFrosting: orderFormViewModel.wantsExtraFrosting,
                addsSprinkles: orderFormViewModel.addsSprinkles
            ),
            deliveryAddress: deliveryAddressFromFormData
        )
    }
    
    
    var deliveryAddressFromFormData: Address {
        Address(
            name: deliveryAddressViewModel.name,
            streetAddress: deliveryAddressViewModel.streetAddress,
            city: deliveryAddressViewModel.city,
            zipCode: deliveryAddressViewModel.zipCode
        )
    }
}



// MARK: - View Variables
extension OrderFormContainerView {
}



// MARK: - Private Helpers
extension OrderFormContainerView {
    
    private func submitOrder(_ order: Order) {
        // TODO: Implement
    }
}


// MARK: - Preview
struct OrderFormContainerView_Previews: PreviewProvider {

    static var previews: some View {
        OrderFormContainerView()
            .environmentObject(SampleStore.default)
    }
}
