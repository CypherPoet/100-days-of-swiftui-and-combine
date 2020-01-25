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
                .foregroundColor(self.color(forItemWith: geometry))
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(word). \(word.count) letters."))
        }
}


// MARK: - Private Helpers
private extension GameView.UsedWordListItem {
        
    func yPercentageInList(forItemWith geometry: GeometryProxy) -> Double {
        let listHeight = listGeometry.size.height
        let listStartY = listGeometry.frame(in: .global).minY
        let itemGlobalEndY = geometry.frame(in: .global).maxY
        let itemHeight = geometry.size.height
        
        return Double(
            (itemGlobalEndY - listStartY - (itemHeight * 2))
            / listHeight
        )
    }
    
    
    func xOffset(forItemWith geometry: GeometryProxy) -> CGFloat {
        let listWidth = listGeometry.size.width
        let yPercentageInList = self.yPercentageInList(forItemWith: geometry)
        
        return yPercentageInList > 1.0 ? listWidth : 0.0
    }
    
    
    func color(forItemWith geometry: GeometryProxy) -> Color {
        let yPercentageInList = self.yPercentageInList(forItemWith: geometry)
            
        return .init(
            red: yPercentageInList * 0.5,
            green: 1.0 - (yPercentageInList / 2.3),
            blue: yPercentageInList * 0.985
        )
    }
}


// MARK: - Preview
struct UsedWordListItem_Previews: PreviewProvider {

    static var previews: some View {
        GameView(viewModel: GameViewModel(rootWords: sampleWords))
    }
}


