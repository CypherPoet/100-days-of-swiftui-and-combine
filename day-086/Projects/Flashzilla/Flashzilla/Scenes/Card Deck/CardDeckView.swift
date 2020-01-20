//
//  CardDeckView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/20/20.
// ✌️
//

import SwiftUI


struct CardDeckView {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

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
            
            
            if self.differentiateWithoutColor {
                VStack {
                    Spacer()

                    self.swipeDirectionIndicators
                }
            }
        }
        .frame(width: width, height: height)
    }
    
    
    private var swipeDirectionIndicators: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            
            Spacer()
            
            
            Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .foregroundColor(.white)
        .font(.largeTitle)
    }
}
