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
                CardDeckView(
                    width: min(max(800, geometry.size.width) * 0.8, 480),
                    height: min(max(800, geometry.size.width) * 0.8, 480) * 0.6,
                    cards: self.viewModel.cards,
                    onRemove: { (card, index) in self.cardRemoved(at: index) }
                )
                .padding()
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
