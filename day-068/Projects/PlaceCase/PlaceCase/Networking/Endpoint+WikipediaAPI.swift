//
//  Endpoint+WikipediaAPI.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/13/19.
// ✌️
//

import Foundation
import CypherPoetNetStack


extension Endpoint {
    
    enum WikipediaAPI {
        private static let host = "en.wikipedia.org"
        private static let basePath = "/w/api.php"

        public static func wikiPages(near location: Location) -> Endpoint {
            .init(
                host: Self.host,
                path: Self.basePath,
                queryItems: [
                    URLQueryItem(name: "ggscoord", value: "\(location.latitude)|\(location.longitude)"),
                    URLQueryItem(name: "action", value: "query"),
                    URLQueryItem(name: "format", value: "json"),
                    URLQueryItem(name: "generator", value: "geosearch"),
                    URLQueryItem(name: "prop", value: "coordinates|pageimages"),
                ]
            )
        }
    }
}
