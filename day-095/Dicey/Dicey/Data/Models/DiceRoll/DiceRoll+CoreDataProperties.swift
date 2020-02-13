//
//  DiceRoll+CoreDataProperties.swift
//  Dicey
//
//  Created by Brian Sipple on 2/1/20.
//  Copyright © 2020 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension DiceRoll {
    @NSManaged public var createdAt: Date
    @NSManaged public var diceValues: [Int16]
}
