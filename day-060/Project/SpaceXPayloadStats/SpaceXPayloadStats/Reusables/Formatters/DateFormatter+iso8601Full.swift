//
//  DateFormatter+iso8601Full.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import Foundation


extension JSONDecoder.DateDecodingStrategy {
    static let iso8601Full = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        
        if let date = DateFormatters.iso8601Full.date(from: string) {
            return date
        }
        
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid date: \(string)"
        )
    }
}


enum DateFormatters {

    /// A custom formatter for  iso8601 dates that include milliseconds.
    ///
    /// See [this Stack Overflow discussion](https://stackoverflow.com/a/46458771/8859365)
    /// for why this is an issue.
    static let iso8601Full: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        return formatter
    }()
}
