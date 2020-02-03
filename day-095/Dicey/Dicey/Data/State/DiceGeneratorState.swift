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


struct DiceGeneratorState {
    
    @UserDefault("Dice Generator State :: roll size", defaultValue: 1)
    var rollSize: Int
    
    
    @UserDefault("Dice Generator State :: allows repeat results", defaultValue: true)
    var allowsRepeatResults: Bool
}



//enum DiceGeneratorSideEffect: SideEffect {
//
//}



enum DiceGeneratorAction {
    case rollSizeSet(Int)
}


// MARK: - Reducer
let diceGeneratorReducer: Reducer<DiceGeneratorState, DiceGeneratorAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .rollSizeSet(let size):
            state.rollSize = size
        }
    }
)

