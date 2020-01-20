//
//  CardDeckContainerView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct CardDeckContainerView {
    @ObservedObject var viewModel: ViewModel = .init()
}


// MARK: - View
extension CardDeckContainerView: View {

    var body: some View {
        GeometryReader { geometry in
            VStack {
                self.cardDeck
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.width * 0.7)
            }
        }
        .background(Color("CardDeckBackground"))
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Computeds
extension CardDeckContainerView {
}


// MARK: - View Variables
extension CardDeckContainerView {
    
    private var cardDeck: some View {
        let deckSize = viewModel.cards.count
        
        return ZStack {
            ForEach(viewModel.cards.indexed(), id: \.1.self) { (index, card) in
                DraggableCardView(
                    card: card,
                    horizontalSensitivity: 1.0,
                    onRemove: { _ in self.cardRemoved(at: index) }
                )
                .stacked(at: index, outOf: deckSize, offsetMultiple: 10)
            }
            
        }
    }
}


// MARK: - Private Helpers
private extension CardDeckContainerView {
    
    func cardRemoved(at index: Int) {
        viewModel.cards.remove(at: index)
    }
}



// MARK: - Preview
struct CardDeckContainerView_Previews: PreviewProvider {

    static var previews: some View {
        CardDeckContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
            .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
