//
//  Book+FetchHelpers.swift
//  Bookworm
//
//  Created by CypherPoet on 11/18/19.
// ✌️
//

import Foundation
import CoreData


extension Book {
    enum SortDescriptors {
        static let `default` = [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
            NSSortDescriptor(keyPath: \Book.author, ascending: true),
        ]
    }
}
