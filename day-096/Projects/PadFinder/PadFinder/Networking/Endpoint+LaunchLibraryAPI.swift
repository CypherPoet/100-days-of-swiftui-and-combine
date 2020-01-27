//
//  Endpoint+LaunchLibraryAPI.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation
import CypherPoetNetStack


extension Endpoint {
    
    enum LaunchLibraryAPI {
        private static let host = "launchlibrary.net"
        private static let basePath = "/1.4"

        
        public static func pads(
            sizeMode: VerbosityMode = .summary
        ) -> Endpoint {
            .init(
                host: self.host,
                path: "\(self.basePath)/pad",
                queryItems: [
                    URLQueryItem(name: "mode", value: sizeMode.rawValue)
                ]
            )
        }
    }
}


extension Endpoint.LaunchLibraryAPI {
    
    /// Specifies how much data to return in each result item
    enum VerbosityMode: String {
        case list
        case summary
        case verbose
    }
}
