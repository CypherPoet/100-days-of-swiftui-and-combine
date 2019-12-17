//
//  Location+Computeds.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/15/19.
// ✌️
//

import Foundation


extension Location {

    var wikiPagesArray: [WikiPage] {
        guard let wikiPages = wikiPages as? Set<WikiPage> else { return [] }
        
        return wikiPages.sorted()
    }

}

