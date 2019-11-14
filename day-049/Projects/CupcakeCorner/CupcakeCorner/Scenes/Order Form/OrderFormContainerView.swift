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

    @ObservedObject var viewModel: OrderFormContainerViewModel
    
    private var orderFormViewModel: OrderFormViewModel
    private var deliveryAddressViewModel: DeliveryAddressFormViewModel

    
    init(
        viewModel: OrderFormContainerViewModel,
        orderFormViewModel: OrderFormViewModel = .init(),
        deliveryAddressViewModel: DeliveryAddressFormViewModel = .init()
    ) {
        self.viewModel = viewModel
        self.orderFormViewModel = orderFormViewModel
        self.deliveryAddressViewModel = deliveryAddressViewModel
    }
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
                                viewModel: CheckoutViewModel(
                                    order: self.orderFromFormData
                                ),
                                onSubmit: self.submitOrder(_:)
                            )
                        }
                    )
                }
            )
            .navigationBarTitle("🧁 Cupcake Corner")
            .alert(isPresented: $viewModel.isShowingSaveConfirmationAlert, content: { self.saveConfirmationAlert })
            .alert(isPresented: $viewModel.isShowingSaveErrorAlert, content: { self.saveErrorAlert })
        }
    }
}



// MARK: - Computeds
extension OrderFormContainerView {

    var ordersState: OrdersState { store.state.ordersState }
    
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
    
    
    var saveConfirmationAlert: Alert {
        .init(
            title: Text("Order Confirmed"),
            message: Text(viewModel.saveConfirmationMessage),
            dismissButton: .default(Text("OK")))
    }
    
    var saveErrorAlert: Alert {
        .init(
            title: Text("An error occurred while processing your order"),
            message: Text(viewModel.saveConfirmationMessage),
            dismissButton: .default(Text("OK")))
    }
}



// MARK: - View Variables
extension OrderFormContainerView {
}



// MARK: - Private Helpers
extension OrderFormContainerView {
    
    private func submitOrder(_ order: Order) {
        store.send(OrdersSideEffect.saveCurrent(order: order))
    }
}


// MARK: - Preview
struct OrderFormContainerView_Previews: PreviewProvider {

    static var previews: some View {
        OrderFormContainerView(
            viewModel: OrderFormContainerViewModel(store: SampleStore.default)
        )
        .environmentObject(SampleStore.default)
    }
}
