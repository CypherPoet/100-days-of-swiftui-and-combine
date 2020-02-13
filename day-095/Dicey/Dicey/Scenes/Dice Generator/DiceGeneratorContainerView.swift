//
//  DiceGeneratorContainerView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorContainerView {
    @EnvironmentObject private var store: AppStore

    @State private var isShowingRollHistory = false
}


// MARK: - View
extension DiceGeneratorContainerView: View {

    var body: some View {
        DiceGeneratorView(
            viewModel: .init(
                diceCount: store.state.diceGeneratorState.rollSize,
                diceCollection: store.state.diceGeneratorState.latestRoll?.diceArray
            ),
            onDiceRolled: onDiceRolled(_:)
        )
        .sheet(isPresented: $isShowingRollHistory) {
            Text("Roll History")
        }
    }
}


// MARK: - Computeds
extension DiceGeneratorContainerView {
    var diceGeneratorState: DiceGeneratorState { store.state.diceGeneratorState }
}


// MARK: - View Variables
extension DiceGeneratorContainerView {
}


// MARK: - Private Helpers
private extension DiceGeneratorContainerView {
    
    func onDiceRolled(_ rollResults: [Dice]) {
        store.send(DiceGeneratorSideEffect.recordNewRoll(rollResults))
    }
}



// MARK: - Preview
struct DiceGeneratorContainerView_Previews: PreviewProvider {

    static var previews: some View {
        DiceGeneratorContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
            .environmentObject(PreviewData.AppStores.default)
    }
}
