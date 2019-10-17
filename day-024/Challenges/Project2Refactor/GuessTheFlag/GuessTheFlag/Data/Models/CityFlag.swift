//
//  CityFlag.swift
//  GuessTheFlag
//
//  Created by CypherPoet on 10/13/19.
// ✌️
//

import Foundation


struct CityFlag: Identifiable {
    let id = UUID()
    
    var cityName: String
    var imageName: String
}

extension CityFlag: Hashable {}


extension CityFlag {
    static var amsterdam = CityFlag(cityName: "Amsterdam", imageName: "amsterdam")
    static var berlin = CityFlag(cityName: "Berlin", imageName: "berlin")
    static var chicago = CityFlag(cityName: "Chicago", imageName: "chicago")
    static var denver = CityFlag(cityName: "Denver", imageName: "denver")
    static var hongKong = CityFlag(cityName: "Hong-Kong", imageName: "hong-kong")
    static var london = CityFlag(cityName: "London", imageName: "london")
    static var losAngeles = CityFlag(cityName: "Los Angeles", imageName: "los-angeles")
    static var paris = CityFlag(cityName: "Paris", imageName: "paris")
    static var riga = CityFlag(cityName: "Riga", imageName: "riga")
    static var toronto = CityFlag(cityName: "Toronto", imageName: "toronto")
    static var washingtonDC = CityFlag(cityName: "Washington DC", imageName: "washington-dc")
}
