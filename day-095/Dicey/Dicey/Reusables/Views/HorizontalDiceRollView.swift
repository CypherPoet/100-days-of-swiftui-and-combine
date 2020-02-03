//
//  HorizontalDiceRollView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct HorizontalDiceRollView {
    var diceCollection: [Dice] = []
}


// MARK: - View
extension HorizontalDiceRollView: View {

    var body: some View {
        Text("Horizontal Dice Roll View")
    }
}


// MARK: - Computeds
extension HorizontalDiceRollView {
}


// MARK: - View Variables
extension HorizontalDiceRollView {
}


// MARK: - Private Helpers
private extension HorizontalDiceRollView {
}



// MARK: - Preview
struct HorizontalDiceRollView_Previews: PreviewProvider {

    static var previews: some View {
        HorizontalDiceRollView()
    }
}
