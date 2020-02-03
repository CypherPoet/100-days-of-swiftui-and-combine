//
//  DiceGeneratorView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorView {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private let diceCountRange = 1...6
    
    @ObservedObject var viewModel: ViewModel
    let onDiceRolled: ((DiceRoll) -> Void)?
}



// MARK: - View
extension DiceGeneratorView: View {

    var body: some View {
        VStack {
            diceCollectionSection
            
            rollButton
            
            controlPanel
        }
    }
}



// MARK: - Computeds
extension DiceGeneratorView {
    var isShowingHorizontalDiceLayout: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
}



// MARK: - View Variables
extension DiceGeneratorView {
    
    private var diceCollectionSection: some View {
        Group {
            if isShowingHorizontalDiceLayout {
                HorizontalDiceRollView(diceCollection: viewModel.diceCollection)
    //                .offset(offsetFromShake)
            } else {
                VerticalDiceRollView(diceCollection: viewModel.diceCollection)
//                .offset(offsetFromShake)
            }
        }
    }

    
    private var rollButton: some View {
        Button(action: {
//            self.onDiceRolled?(viewModel.diceRollFromForm)
        }) {
            Text("Roll")
        }
    }
    
    
    private var controlPanel: some View {
        Form {
            HStack {
                Text("Dice Count")
                
                Spacer()
                
                Text("\(viewModel.diceCount)")
                Stepper("Dice Count", value: viewModel.$diceCount, in: diceCountRange)
                    .labelsHidden()
            }
        }
    }
}



// MARK: - Private Helpers
private extension DiceGeneratorView {
    
    
}



// MARK: - Preview
struct DiceGeneratorView_Previews: PreviewProvider {

    static var previews: some View {
        DiceGeneratorView(
            viewModel: .init(
                diceCount: .constant(2)
//                diceRoll: .constant(diceRoll)
            ),
            onDiceRolled: { _ in }
        )
    }
}
