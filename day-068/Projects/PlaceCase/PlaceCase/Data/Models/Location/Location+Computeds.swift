//
//  Location+Computeds.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/15/19.
// ✌️
//

import SwiftUI

extension Location {

    var wikiPagesArray: [WikiPage] {
        guard let wikiPages = wikiPages as? Set<WikiPage> else { return [] }
        
        return wikiPages.sorted()
    }
    
    
    var userPhoto: Image? {
        guard
            let data = userPhotoData,
            let uiImage = UIImage(data: data)
        else { return nil }
     
        return Image(uiImage: uiImage)
    }
}

