//
//  Game.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import SwiftUI
import Combine


final class Game: ObservableObject {
    @Published var currentScore: Int = 0
    @Published var currentRound: Int = 0
    let roundLimit: Int = 10
    
    @Published var currentItem: GameItem = .rock
    @Published var desiredOutcome: Outcome = .win
    
    @Published var isShowingAlert = false
    
    var latestAnswer: GameItem?
    var latestDesiredOutcome: Outcome?
    var latestAnswerWasCorrect: Bool = false
}


// MARK: - Computeds
extension Game {
    var isGameOver: Bool { currentRound == roundLimit }
    
    private var resultAlertTitle: String { latestAnswerWasCorrect ? "Correct 👏" : "Sorry" }
    
    private var resultAlertFeedbackLine1: String {
        guard
            let latestAnswer = latestAnswer,
            let latestDesiredOutcome = latestDesiredOutcome
        else { return "" }
        
        switch latestDesiredOutcome {
        case .win:
            return latestAnswer.howToWin
        case .lose:
            return latestAnswer.howToLose
        }
    }
    
    
    private var resultAlertFeedbackLine2: String {
        let desiredOutcomeText = latestDesiredOutcome == .win ? "won" : "lost"
        
        return "You would have \(desiredOutcomeText) this round."
    }
    
    
    private var resultAlertMessage: String {
        let scoreLine = "Your score is now \(currentScore)."
        
        return """
        
        \(resultAlertFeedbackLine1)
        \(resultAlertFeedbackLine2)
        
        \(scoreLine)
        """
    }
    
    
    private var gameOverAlert: Alert {
        Alert(
            title: Text("Game Over"),
            message: Text("You finisehd with \(currentScore) points."),
            dismissButton: .default(
                Text("Play Again"),
                action: {
                    self.startNewGame()
                }
            )
        )
    }
    
    
    private var resultAlert: Alert {
        Alert(
            title: Text(resultAlertTitle),
            message: Text(resultAlertMessage),
            dismissButton: .default(
                Text("Continue"),
                action: {
                    self.incrementRound()
                }
            )
        )
    }
    
    
    var currentAlert: Alert! {
        return isGameOver ? gameOverAlert : resultAlert
    }
    
}


// MARK: - Public Methods
extension Game {
    
    func startNewGame() {
        currentScore = 0
        currentRound = 1
        
        configureRound()
    }
    
    
    func incrementRound() {
        currentRound += 1
        
        configureRound()
    }
    
    
    func configureRound() {
        currentItem = GameItem.allCases.randomElement()!
        desiredOutcome = Outcome.allCases.randomElement()!
    }
    
    
    /// - Parameter completionHandler: Returns a `Bool` indicating whether or not the
    ///     answer was correct
    func check(
        answer: GameItem,
        then completionHandler: ((Bool) -> Void)? = nil
    ) {
        guard answer != currentItem else {
            preconditionFailure("Draws should not be submitted for win/loss evaluation")
        }
        
        latestAnswer = answer
        latestDesiredOutcome = desiredOutcome
        
        let isCorrectAnswer: Bool
        
        switch desiredOutcome {
        case .lose:
            isCorrectAnswer = answer.does(loseTo: currentItem)
        case .win:
            isCorrectAnswer = answer.does(winAgainst: currentItem)
        }
        
        currentScore += isCorrectAnswer ? 1 : -1
        latestAnswerWasCorrect = isCorrectAnswer
        completionHandler?(latestAnswerWasCorrect)
    }
}
