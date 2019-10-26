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
            completionHandler(true)
        } else {
            currentScore = max(0, currentScore - 3)
            latestChoiceWasCorrect = false
            completionHandler(false)
        }
    }
    
    
    public func startNewGame() {
        currentRound = 1
        currentScore = 0
        
        computedNewFlagChoices()
    }
    
    
    public func incrementRound() {
        currentRound += 1
        computedNewFlagChoices()
    }
}


// MARK: - Private Helpers
extension FlagGame {
    private func computedNewFlagChoices() {
        flagChoices = Array(flagsStore.flags.shuffled()[0...2])
        flagToGuess = flagChoices.randomElement()
    }
}
