//
//  Pad.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation
import CoreLocation


struct Pad {
    let id: Int
    var name: String
    var padType: PadType
    var mapURL: URL
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var isRetired: Bool
    var infoURLs: [URL]
}


extension Pad: Identifiable {}


extension Pad {
    static func isRetired(int: Int) -> Bool {
        int == 1
    }
}

// MARK: - Decodable
extension Pad: Decodable {
    struct ResultsContainer: Decodable {
        var pads: [Pad]
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case padType = "padType"
        case mapURL = "mapURL"
        case latitude = "latitude"
        case longitude = "longitude"
        case isRetired = "retired"
        case infoURLs = "infoURLs"
    }
    

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        padType = try container.decode(PadType.self, forKey: .padType)
        
        let mapURLString = try container.decode(String.self, forKey: .mapURL)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        mapURL = URL(string: mapURLString)!
//        if mapURL == nil {
//            print("failed to make URL from string \(mapURLString)")
//        }
        
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        latitude = CLLocationDegrees(latitudeString) ?? 0.0
        
        let longitudeString = try container.decode(String.self, forKey: .longitude)
        longitude = CLLocationDegrees(longitudeString) ?? 0.0
        
        let isRetiredInt = try container.decode(Int.self, forKey: .isRetired)
        
        isRetired = Pad.isRetired(int: isRetiredInt)
        infoURLs = try container.decodeIfPresent([URL].self, forKey: .infoURLs) ?? []
    }
}


extension Pad {
    static var decoder: JSONDecoder {
        .init()
    }
}
