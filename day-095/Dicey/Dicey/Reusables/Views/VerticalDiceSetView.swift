//
//  VerticalDiceSetView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct VerticalDiceSetView {
    var diceCount: Int = 1
    var diceSideLength: CGFloat = 40.0
}


// MARK: - View
extension VerticalDiceSetView: View {

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.purple)
                .frame(
                    width: (geometry.size.width / CGFloat(self.columnCount)) - (self.columnSpacing * (CGFloat(self.columnCount - 1))),
                    height: (geometry.size.height / CGFloat(self.rowCount)) - (self.rowSpacing * CGFloat((self.rowCount - 1)))
            )
        }
    }
}


// MARK: - Computeds
extension VerticalDiceSetView {
    var rowSpacing: CGFloat { 16.0 }
    var columnSpacing: CGFloat { 20.0 }
    
    var rowCount: Int { ((diceCount - 1) / 2) + 1 }
    var columnCount: Int { (diceCount / 2) + 1 }
//    var rowCount: Int { 1 }
//    var columnCount: Int { 1 }
}


// MARK: - View Variables
extension VerticalDiceSetView {
}


// MARK: - Private Helpers
private extension VerticalDiceSetView {
    
    func diceSideLength(in geometry: GeometryProxy) {
        let maxDimension = max(geometry.size.width, geometry.size.height)
        
    }
}



// MARK: - Preview
struct DiceSetView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            VerticalDiceSetView(
                diceCount: 4
            )
        }
//        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
    }
}
