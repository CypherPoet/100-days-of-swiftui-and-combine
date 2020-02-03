//
//  Dice+CoreDataClass.swift
//  Dicey
//
//  Created by Brian Sipple on 2/1/20.
//  Copyright © 2020 CypherPoet. All rights reserved.
//
//

import Foundation


enum Dice: Int16 {
    case one = 1
    case two
    case three
    case four
    case five
    case six
}

extension Dice: CaseIterable {}

extension Dice: Identifiable {
    var id: Int16 { rawValue }
}
