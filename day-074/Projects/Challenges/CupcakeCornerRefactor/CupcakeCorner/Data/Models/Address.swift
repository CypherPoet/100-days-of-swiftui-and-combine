//
//  Address.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//

import Foundation


struct Address {
    var name: String
    var streetAddress: String
    var city: String
    var zipCode: String
}

extension Address: Codable {}
