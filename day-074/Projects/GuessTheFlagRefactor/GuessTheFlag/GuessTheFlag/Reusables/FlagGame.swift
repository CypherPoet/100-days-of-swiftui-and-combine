//
//  FlagGame.swift
//  GuessTheFlag
//
//  Created by CypherPoet on 10/13/19.
// ✌️
//

import Combine
import SwiftUI


final class FlagGame: ObservableObject {
    @ObservedObject var flagsStore = FlagsStore()
    
    @Published var currentRound: Int = -1
    @Published var currentScore: Int = -1
    @Published var flagChoices: [CityFlag] = []
    
    @Published var previousChoice: CityFlag?

    @Published var flagToGuess: CityFlag!
    @Published var latestChoice: CityFlag? = nil
    @Published var latestChoiceWasCorrect = false
    
    
    @Published var flagRotations: [Double] = [
        0.0,
        0.0,
        0.0,
    ]
    
    @Published var flagOpacities: [Double] = [
        1.0,
        1.0,
        1.0,
    ]
    
    
    init() {
        startNewGame()
    }
}


// MARK: - Public Methods
extension FlagGame {
    
    /// - Parameter completionHandler: Returns a `Bool` indicating whether or not the
    ///     choice was correct.
    func makeGuess(
        with flag: CityFlag,
        then completionHandler: ((Bool) -> Void)
    ) {
        latestChoice = flag
        
        if flag == flagToGuess {
            currentScore += 1
            latestChoiceWasCorrect = true
        } else {
            currentScore = max(0, currentScore - 3)
            latestChoiceWasCorrect = false
        }
        
        completionHandler(latestChoiceWasCorrect)
    }
    
    
    public func startNewGame() {
        currentRound = 1
        currentScore = 0
        
        resetFlagAppearances()
        computedNewFlagChoices()
    }
    
    
    public func incrementRound() {
        currentRound += 1
        
        resetFlagAppearances()
        computedNewFlagChoices()
    }
}


// MARK: - Private Helpers
extension FlagGame {
    
    private func computedNewFlagChoices() {
        flagChoices = Array(flagsStore.flags.shuffled()[0...2])
        flagToGuess = flagChoices.randomElement()
    }
    
    
    func resetFlagAppearances() {
        flagOpacities = [1.0, 1.0, 1.0]
    }
    
    
    private func updateFlagAppearancesAfterGuess() {
        guard
            let latestChoice = latestChoice,
            let choiceIndex = flagChoices.firstIndex(of: latestChoice)
        else { fatalError() }
        
 
        flagRotations[choiceIndex] = latestChoiceWasCorrect ? 0.0 : (2 * .pi)
        flagOpacities[choiceIndex] = latestChoiceWasCorrect ? 1.0 : 0.2
    }
}
