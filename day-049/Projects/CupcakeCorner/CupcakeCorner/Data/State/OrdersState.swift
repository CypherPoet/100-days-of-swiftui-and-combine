//
//  PricesState.swift
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetSwiftUIKit


struct OrdersState {
    var currentOrder: Order? = nil
}


//enum OrdersSideEffect: SideEffect {
//    case saveCurrentOrder
//
//
//    func mapToAction() -> AnyPublisher<AppAction, Never> {
//        switch self {
//        case .saveCurrentOrder:
//
//        }
//    }
//}



enum OrdersAction {
    case orderSaved
}



// MARK: - Reducer
let ordersReducer = Reducer<OrdersState, OrdersAction> { state, action in
    switch action {
    case .orderSaved:
        state.currentOrder = nil
    }
}
