//
//  DiceGeneratorState.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils
import CypherPoetPropertyWrappers_UserDefault
import CypherPoetCoreDataKit


struct DiceGeneratorState {
    @UserDefault("Dice Generator State :: roll size", defaultValue: 1)
    var rollSize: Int
    
    @UserDefault("Dice Generator State :: allows repeat results", defaultValue: true)
    var allowsRepeatResults: Bool

    var latestRoll: DiceRoll?
}



enum DiceGeneratorSideEffect: SideEffect {
    case recordNewRoll([Dice])
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case .recordNewRoll(let rollResults):
            return Just(rollResults)
                .map { diceCollection -> DiceRoll in
                    let context = CurrentApp.coreDataManager.backgroundContext
                    let diceRoll = DiceRoll(context: context)
                    
                    diceRoll.createdAt = Date()
                    diceRoll.diceValues = diceCollection.map { $0.rawValue }
                    
                    return diceRoll
                }
                .flatMap { diceRoll in
                    CurrentApp.coreDataManager.save(diceRoll.managedObjectContext!)
                        .map { AppAction.diceGenerator(.latestRollSet(diceRoll)) }
                        .catch { error in
                            // 📝 Better error handling could be placed here.
                            Just(AppAction.diceGenerator(.rollSizeSet(diceRoll.diceValues.count)))
                        }
                }
                .eraseToAnyPublisher()
        }
    }
}



enum DiceGeneratorAction {
    case rollSizeSet(Int)
    case latestRollSet(DiceRoll)
}


// MARK: - Reducer
let diceGeneratorReducer: Reducer<DiceGeneratorState, DiceGeneratorAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .rollSizeSet(let size):
            state.rollSize = size
        case .latestRollSet(let diceRoll):
            state.latestRoll = diceRoll
            state.rollSize = diceRoll.diceValues.count
        }
    }
)

