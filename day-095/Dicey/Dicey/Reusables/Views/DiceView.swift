//
//  DiceView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceView {
    var dice: Dice
    
    static let images: [Dice: Image] = [
        .one: Image(Dice.one.imageName),
        .two: Image(Dice.two.imageName),
        .three: Image(Dice.three.imageName),
        .four: Image(Dice.four.imageName),
        .five: Image(Dice.five.imageName),
        .six: Image(Dice.six.imageName),
    ]
}


// MARK: - View
extension DiceView: View {

    var body: some View {
        Self.images[dice]?
            .resizable()
            .scaledToFit()
    }
}


// MARK: - Computeds
extension DiceView {
}


// MARK: - View Variables
extension DiceView {
}


// MARK: - Private Helpers
private extension DiceView {
}


// MARK: - Preview
struct DiceView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            DiceView(dice: Dice.allCases.randomElement()!)
        }
    }
}
