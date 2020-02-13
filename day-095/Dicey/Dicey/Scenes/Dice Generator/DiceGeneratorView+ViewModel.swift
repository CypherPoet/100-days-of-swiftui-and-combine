//
//  DiceGeneratorView+ViewModel.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//


import SwiftUI
import Combine


extension DiceGeneratorView {
    final class ViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()

        
        // MARK: - Published Outputs
        @Published var diceCount: Int
        @Published var rollResults: [Dice] = []


        // MARK: - Init
        init(
            diceCount: Int,
            diceCollection: [Dice]? = nil
        ) {
            self.diceCount = diceCount
            self.rollResults = diceCollection ?? (1...diceCount).map { _ in .one }
            
            setupSubscribers()
        }
    }
}


    
// MARK: - Publishers
extension DiceGeneratorView.ViewModel {

    private var diceCollectionPublisher: Publishers.Share<AnyPublisher<[Dice], Never>> {
        Publishers.CombineLatest(
            $diceCount,
            CurrentValueSubject(rollResults)
        )
        .print("diceCollectionPublisher")
        .map { (diceCount, results) in
            let rollResultsCount = results.count

            return (0 ..< diceCount).map { index -> Dice in
                if index <= (rollResultsCount - 1) {
                    // use result
                    return results[index]
                } else {
                    // make new "starting" dice
                    return .one
                }
            }
        }
        .eraseToAnyPublisher()
        .share()
    }
}


// MARK: - Computeds
extension DiceGeneratorView.ViewModel {
}


// MARK: - Public Methods
extension DiceGeneratorView.ViewModel {
    
    func generateRollResults() -> [Dice] {
        (1...diceCount).map { _ in Dice(rawValue: Int16.random(in: 1...6))! }
    }
}



// MARK: - Private Helpers
private extension DiceGeneratorView.ViewModel {

    func setupSubscribers() {
        diceCollectionPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.rollResults, on: self)
            .store(in: &subscriptions)
    }
}
