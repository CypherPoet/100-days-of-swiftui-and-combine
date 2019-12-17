//
//  WikiPage.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/13/19.
// ✌️
//

import Foundation
import CoreData
import CypherPoetCoreDataKit


/// "Wrapper" structure for decoding the API payload.
struct WikiPagesResult: Decodable {
    var query: WikiPagesResultQuery?
    
    struct WikiPagesResultQuery: Decodable {
        var pages: [Int: WikiPage]?
    }
}


extension WikiPage {
    static let decoder = JSONDecoder()
}
