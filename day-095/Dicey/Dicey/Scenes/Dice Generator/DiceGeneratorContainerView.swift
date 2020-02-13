//
//  DiceGeneratorContainerView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorContainerView {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @EnvironmentObject private var store: AppStore

    @State private var isShowingRollHistory = false
}


// MARK: - View
extension DiceGeneratorContainerView: View {

    var body: some View {
        NavigationView {
            DiceGeneratorView(
                viewModel: .init(
                    diceCount: store.state.diceGeneratorState.rollSize,
                    diceCollection: store.state.diceGeneratorState.latestRoll?.diceArray
                ),
                onDiceRolled: onDiceRolled(_:)
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: historyButton)
        }
        .sheet(isPresented: $isShowingRollHistory) {
            DiceRollHistoryContainerView()
                .environment(\.managedObjectContext, self.managedObjectContext)
                .accentColor(.purple)
        }
    }
}


// MARK: - Computeds
extension DiceGeneratorContainerView {
    var diceGeneratorState: DiceGeneratorState { store.state.diceGeneratorState }
}


// MARK: - View Variables
extension DiceGeneratorContainerView {
    
    private var historyButton: some View {
        Button(action: {
            self.isShowingRollHistory = true
        }) {
            Text("History")
        }
    }
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
