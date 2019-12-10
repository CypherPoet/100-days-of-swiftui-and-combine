//
//  Double+IsValidCoordinate.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation


extension Double {

    /// 📝 [Discusssion](https://stackoverflow.com/questions/6536232/validate-latitude-and-longitude/6536279#6536279)
    public var isValidLatitude: Bool {
        self >= -90 && self <= 90
    }
    
    
    /// 📝 [Discusssion](https://stackoverflow.com/questions/6536232/validate-latitude-and-longitude/6536279#6536279)
    public var isValidLongitude: Bool {
        self >= -180 && self <= 180
    }
}
