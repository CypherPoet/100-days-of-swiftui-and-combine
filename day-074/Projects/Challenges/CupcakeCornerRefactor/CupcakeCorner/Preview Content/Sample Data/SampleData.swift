//
//  SampleData.swift
//  BitcoinAverageAPIFetcher
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import SwiftUI



#if DEBUG

import Foundation


enum SampleAddress {
    static let address1 = Address(
        name: "Star Fox",
        streetAddress: "123 Main Street",
        city: "New York",
        zipCode: "10005"
    )
}


enum SampleOrder {
    static let order1 = Order(
        cupcake: Cupcake(flavor: .rainbow),
        quantity: 3,
        preferences: .default,
        deliveryAddress: SampleAddress.address1
    )
}


enum SampleOrdersState {
    static let `default` = OrdersState(currentOrder: SampleOrder.order1)
}


enum SampleAppState {
    static let `default` = AppState(
        ordersState: SampleOrdersState.default
    )
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}


#endif
