//
//  CheckoutViewModel.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//


import SwiftUI
import Combine


final class CheckoutViewModel: ObservableObject {
    var order: Order
    
    
    // MARK: - Init
    init(order: Order) {
        self.order = order
    }
}


// MARK: - Computeds
extension CheckoutViewModel {

    var formattedCostText: String {
        NumberFormatters.orderCost.string(from: order.cost as NSNumber) ?? ""
    }
    
    
    var costText: String {
        "Your total is \(formattedCostText) Satoshis"
    }
    
    
    var orderQuantityText: String {
        let cupcakeString = order.quantity == 1 ? "Cupcake" : "Cupcakes"
        
        return "Ordering \(order.quantity) \(cupcakeString)"
    }
}
