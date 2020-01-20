//
//  CardDeckView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/20/20.
// ✌️
//

import SwiftUI


struct CardDeckView {
    var width: CGFloat
    var height: CGFloat
    
    var cards: [Card]
    var onRemove: ((Card, Int) -> Void)?
}


extension CardDeckView: View {

    var body: some View {
        let deckSize = cards.count
        
        return ZStack {
            ForEach(cards.indexed(), id: \.1.self) { (index, card) in
                DraggableCardView(
                    card: card,
                    distanceToDragForRemoval: self.width / 2,
                    horizontalSensitivity: 1.0,
                    onRemove: { _ in self.onRemove?(card, index) }
                )
                .stacked(at: index + 1, outOf: deckSize, offsetMultiple: CGFloat(30 / deckSize))
            }
        }
        .frame(width: width, height: height)
    }
}
