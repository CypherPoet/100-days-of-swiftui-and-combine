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
    @Environment(\.accessibilityEnabled) var isAccessibilityEnabled

    var width: CGFloat
    var height: CGFloat
    
    var cards: [Card]
    var cardAnswered: ((Card.AnswerState, Int) -> Void)?
}


// MARK: - View
extension CardDeckView: View {

    var body: some View {
        let deckSize = cards.count
        
        return ZStack {
            ForEach(cards.indexed(), id: \.1.self) { (index, card) in
                DraggableCardView(
                    card: card,
                    distanceToDragForRemoval: self.width / 2,
                    horizontalSensitivity: 1.0,
                    onRemove: { (_, answerState) in self.cardAnswered?(answerState, index) }
                )
                .stacked(at: index + 1, outOf: deckSize, offsetMultiple: CGFloat(30 / deckSize))
                .allowsHitTesting(index == deckSize - 1)
                .accessibility(hidden: index < deckSize - 1)
                .accessibility(addTraits: .isButton)
            }
            
            
            if isShowingDeckControls {
                VStack {
                    Spacer()

                    self.deckControls
                }
            }
        }
        .frame(width: width, height: height)
    }
    
}


// MARK: -  Computeds
extension CardDeckView {
    
    var isShowingDeckControls: Bool {
        differentiateWithoutColor &&
        isAccessibilityEnabled &&
        !cards.isEmpty
    }
}


// MARK: -  View Variables
extension CardDeckView {
    
    private var markIncorrectButton: some View {
        Button(action: {
            self.cardAnswered?(.incorrect, self.cards.count - 1)
        }) {
            Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .accessibility(label: Text("Wrong Answer"))
        .accessibility(hint: Text("Mark your answer as being incorrect."))
    }
    
    
    private var markCorrectButton: some View {
        Button(action: {
            withAnimation {
                self.cardAnswered?(.correct, self.cards.count - 1)
            }
        }) {
            Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .accessibility(label: Text("Correct Answer"))
        .accessibility(hint: Text("Mark your answer as being correct."))
    }
    
    
    private var deckControls: some View {
        HStack {
            markIncorrectButton
            Spacer()
            markCorrectButton
        }
        .foregroundColor(.white)
        .font(.largeTitle)
    }
}
