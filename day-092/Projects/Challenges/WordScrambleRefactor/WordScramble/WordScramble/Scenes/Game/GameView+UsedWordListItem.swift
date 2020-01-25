//
//  GameView+UsedWordListItem.swift
//  WordScramble
//
//  Created by CypherPoet on 1/25/20.
// ✌️
//

import SwiftUI


extension GameView {

    struct UsedWordListItem {
        let word: String
        let listGeometry: GeometryProxy
    }
}


// MARK: - View
extension GameView.UsedWordListItem: View {
        var body: some View {
            GeometryReader { geometry in
                HStack {
                    Text(self.word)
                    Spacer()
                    Image(systemName: "\(self.word.count).circle")
                        .imageScale(.large)
                }
                .offset(x: self.xOffset(forItemWith: geometry))
                .animation(.easeOut(duration: 0.4))
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(word). \(word.count) letters."))
        }
}


// MARK: - Private Helpers
extension GameView.UsedWordListItem {
        
    func xOffset(forItemWith geometry: GeometryProxy) -> CGFloat {
        let listWidth = listGeometry.size.width
        let listHeight = listGeometry.size.height
        let listStartY = listGeometry.frame(in: .global).minY
        let itemGlobalEndY = geometry.frame(in: .global).maxY
        let itemHeight = geometry.size.height
        
        let yPercentageInList = (itemGlobalEndY - listStartY - (itemHeight * 2)) / listHeight
        
        return yPercentageInList > 1.0 ? listWidth : 0.0
    }
}

