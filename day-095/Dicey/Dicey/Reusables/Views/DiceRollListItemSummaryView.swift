//
//  DiceRollListItemSummaryView.swift
//  Dicey
//
//  Created by CypherPoet on 2/13/20.
// ✌️
//

import SwiftUI


struct DiceRollListItemSummaryView {
    var diceRoll: DiceRoll
}


// MARK: - View
extension DiceRollListItemSummaryView: View {

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(
                    Array(self.diceRoll.diceArray.enumerated()), id: \.offset
                ) { (index, dice) in
                    Group {
                        RoundedRectangle(cornerRadius: geometry.size.height * 0.1)
                            .fill(Color.accentColor.opacity(0.8))
                            .frame(
                                width: geometry.size.height * 0.86,
                                height: geometry.size.height * 0.86
                            )
                            .overlay(
                                Text("\(dice.rawValue)")
                                    .foregroundColor(.white)
                            )
                            .padding(.horizontal, geometry.size.height * 0.1)
                        
                        
                        if index < (self.diceRoll.diceArray.count - 1) {
                            RoundedRectangle(cornerRadius: .infinity)
                                .fill(Color.secondary)
                                .frame(
                                    width: geometry.size.height * 0.2,
                                    height: geometry.size.height * 0.0667
                            )
                        }
                    }
                }
            }
        }
    }
}


// MARK: - View Variables
extension DiceRollListItemSummaryView {
}



// MARK: - Preview
struct DiceRollListItemSummaryView_Previews: PreviewProvider {

    static var previews: some View {
        List {
            DiceRollListItemSummaryView(
                diceRoll: PreviewData.DiceRolls.sixDice
                
            )
        }
    }
}
