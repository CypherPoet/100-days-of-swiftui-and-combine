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

        private var rollResults: [Dice] = []
        
        @Binding var diceCount: Int
        
        
        // MARK: - Published Outputs
        @Published var diceCollection: [Dice] = []


        // MARK: - Init
        init(
            diceCount: Binding<Int>
        ) {
            self._diceCount = diceCount
            
            setupSubscribers()
        }
    }
}


    
// MARK: - Publishers
extension DiceGeneratorView.ViewModel {

    private var rollResultsPublisher: AnyPublisher<[Dice], Never> {
        CurrentValueSubject(rollResults)
            .eraseToAnyPublisher()
    }
    
    
    private var diceCollectionPublisher: Publishers.Share<AnyPublisher<[Dice], Never>> {
        Publishers.CombineLatest(
            CurrentValueSubject(diceCount),
            rollResultsPublisher
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
}



// MARK: - Private Helpers
private extension DiceGeneratorView.ViewModel {

    func setupSubscribers() {
        diceCollectionPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.diceCollection, on: self)
            .store(in: &subscriptions)
    }
}
