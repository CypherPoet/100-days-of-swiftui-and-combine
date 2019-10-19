//
//  GameOptionButton.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/18/19.
// ✌️
//

import SwiftUI


struct GameOptionButton: View {
    let gameItem: GameItem
    let opposingGameItem: GameItem
    
    @Binding var currentSelection: GameItem?
    
    var isSelected: Bool { gameItem == currentSelection }
    
    var body: some View {
    
        Button(action: {
            guard self.gameItem != self.opposingGameItem else { return }
            
            self.currentSelection = self.gameItem
        }) {
            gameItem.decorativeImage
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
        }
        .opacity(isSelected ? 1.0 : 0.3)
        .animation(.easeIn(duration: 0.17))
        .frame(width: 70, height: 70)
    }
}
