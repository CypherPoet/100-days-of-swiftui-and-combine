//
//  RootView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI


struct RootView {
    @FetchRequest(sortDescriptors: [], animation: nil) var cardDecks: FetchedResults<CardDeck>
}


// MARK: - View
extension RootView: View {

    var body: some View {
        // 📝 In a production app, we'd want to make sure that the user's
        // decks were properly fetched here.
        CardDeckContainerView(
            viewModel: .init(cardDeck: cardDecks.first!)
        )
    }
}


// MARK: - Computeds
extension RootView {
}


// MARK: - View Variables
extension RootView {
}


// MARK: - Private Helpers
private extension RootView {
}



// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
