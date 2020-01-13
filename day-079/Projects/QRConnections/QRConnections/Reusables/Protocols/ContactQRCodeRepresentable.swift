//
//  ContactQRCodeRepresentable.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//

import Foundation


public protocol ContactQRCodeRepresentable {
    var uuid: UUID { get }
    var name: String { get }
}
