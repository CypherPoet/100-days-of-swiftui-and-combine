//
//  DiceGeneratorContainerView.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import SwiftUI


struct DiceGeneratorContainerView {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject private var store: AppStore

    private var diceCount: Binding<Int> {
        store.binding(
            for: \.diceGeneratorState.rollSize,
            onChange: { .diceGenerator(.rollSizeSet($0)) }
        )
    }
    
    @State private var isShowingRollHistory = false
}


// MARK: - View
extension DiceGeneratorContainerView: View {

    var body: some View {
        DiceGeneratorView(
            viewModel: .init(
                diceCount: diceCount
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
    
    func onDiceRolled(_ diceRoll: DiceRoll) {
        guard let context = diceRoll.managedObjectContext else { preconditionFailure() }
        
        CurrentApp.coreDataManager.save(context)
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
