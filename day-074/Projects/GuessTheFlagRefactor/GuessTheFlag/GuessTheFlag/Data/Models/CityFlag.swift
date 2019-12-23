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
    var accessibilityDescription: String
}

extension CityFlag: Hashable {}


extension CityFlag {
    static var amsterdam = CityFlag(
        cityName: "Amsterdam",
        imageName: "amsterdam",
        accessibilityDescription: "A flag with 2 red horiontal stripes at the edges, a black stripe in the middle, and 3 \"X\"s along the middle."
    )
    static var berlin = CityFlag(
        cityName: "Berlin",
        imageName: "berlin",
        accessibilityDescription: "A flag with 2 red horiontal stripes at the edges, a larger middle white stripe, and a bear standing on its legs in the middle white stripe."
    )
    static var chicago = CityFlag(
        cityName: "Chicago",
        imageName: "chicago",
        accessibilityDescription: "A flag with 2 light-blue horiontal stripes at the edges, a larger middle white stripe, and four red six-pointed stars along the middle white stripe."
    )
    static var denver = CityFlag(
        cityName: "Denver",
        imageName: "denver",
        accessibilityDescription: "A flag with two red triangles representing mountains, a blue background representing the sky, and a yellow circle in the middle representing the sun."
    )
    static var hongKong = CityFlag(
        cityName: "Hong-Kong",
        imageName: "hong-kong",
        accessibilityDescription: "A flag with a white, five-leaf spiral flower centered on a red background."
    )
    static var london = CityFlag(
        cityName: "London",
        imageName: "london",
        accessibilityDescription: "A white flag with a thing red cross evenly dividing it into four quadrants. A red sword is pictured in the top-left quadrant."
    )
    static var losAngeles = CityFlag(
        cityName: "Los Angeles",
        imageName: "los-angeles",
        accessibilityDescription: "A flag with three vertical, jagged stripes -- colored green, yellow, and red from left to right. The city seal is in the middle."
    )
    static var paris = CityFlag(
        cityName: "Paris",
        imageName: "paris",
        accessibilityDescription: "A flag with a left blue and red right vertical stripe. The city seal is in the middle, which includes a ship and a wreath."
    )
    static var riga = CityFlag(
        cityName: "Riga",
        imageName: "riga",
        accessibilityDescription: "A flag with two vertical stripes: light blue on top and white on the bottom. The city seal is in the middle, which includes two lions facing each other."
    )
    static var toronto = CityFlag(
        cityName: "Toronto",
        imageName: "toronto",
        accessibilityDescription: "A flag with a prominant white \"T\" shape that also contains a red maple leaf."
    )
    static var washingtonDC = CityFlag(
        cityName: "Washington DC",
        imageName: "washington-dc",
        accessibilityDescription: "A flag with two horizontal red stripes in front of a white background. Three red stars reside just above the top red stripe."
    )
}
