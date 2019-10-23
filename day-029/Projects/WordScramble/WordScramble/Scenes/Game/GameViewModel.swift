//
//  GameViewModel.swift
//  WordScramble
//
//  Created by CypherPoet on 10/23/19.
// ✌️
//

import Foundation
import Combine
import UIKit


final class GameViewModel: ObservableObject {
    @Published var allRootWords: [String] = []
    @Published var currentRootWord: String = ""
    @Published var currentGuess: String = ""
    @Published var usedWords: [String] = []
    

    @Published var shouldShowErrorAlert: Bool = false
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    
    private static let textChecker = UITextChecker()
}


// MARK: -  Init
extension GameViewModel {
    convenience init(rootWords: [String]) {
        self.init()
        self.allRootWords = rootWords
        
        startNewRound()
    }
}


// MARK: - Computeds
extension GameViewModel {
    
    var currentGuessIsOriginal: Bool {
        !usedWords.contains(currentGuess)
    }
    
    
    var currentGuessIsAnagram: Bool {
        let guessSet = NSCountedSet(array: Array(currentGuess))
        let rootWordSet = NSCountedSet(array: Array(currentRootWord))
        
        return guessSet.allSatisfy { character in
            guessSet.count(for: character) <= rootWordSet.count(for: character)
        }
    }
    
    
    var currentGuessIsRealWord: Bool {
        let wordRange = NSRange(location: 0, length: currentGuess.utf16.count)
        
        let misspelledRange = Self.textChecker.rangeOfMisspelledWord(
            in: currentGuess,
            range: wordRange,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
}


// MARK: - Public Methods
extension GameViewModel {
    
    func startNewRound() {
        usedWords.removeAll(keepingCapacity: true)
        currentGuess = ""
        
        currentRootWord = allRootWords.randomElement()!
    }
    
    
    func checkNewWord() {
        let word = currentGuess.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
        guard !word.isEmpty else { return } // TODO: Better error handling here
 
        guard word != currentRootWord else {
            setWordError(
                title: "Mix it up!",
                message: "Your answer shouldn't match the original word."
            )
            return
        }
        
        guard currentGuessIsOriginal else {
            setWordError(
                title: "Be original!",
                message: "You've already used \"\(word)\" as an anagram for \"\(currentRootWord)\"."
            )
            return
        }
        
        guard currentGuessIsAnagram else {
            setWordError(
                title: "Try Again",
                message: "\"\(word)\" is not an anagram for \"\(currentRootWord)\"."
            )
            return
        }
        
        guard currentGuessIsRealWord else {
            setWordError(
                title: "Is that a word?",
                message: "Unfortunatley, we don't recognize \"\(word)\" as a valid English word 🤷‍♂️."
            )
            return
        }
        
        
        usedWords.insert(word, at: 0)
        currentGuess = ""
    }
}


extension GameViewModel {
    
    func setWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        shouldShowErrorAlert = true
    }
}



#if DEBUG
let sampleWords = [
    "coffee",
    "cambridge",
    "digital",
    "agency",
    "wordsmith",
    "fahrenheit",
    "network",
]
#endif
