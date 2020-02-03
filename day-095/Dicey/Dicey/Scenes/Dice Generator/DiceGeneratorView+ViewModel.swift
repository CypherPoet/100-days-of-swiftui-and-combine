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

//        private let diceGeneratorState: DiceGeneratorState
        private var rollResults: [Dice] = []
        
        @Binding var diceCount: Int
//        @Binding var diceRoll: DiceRoll
        
        
        // MARK: - Published Outputs
        @Published var diceCollection: [Dice] = []


        // MARK: - Init
        init(
//            diceGeneratorState: DiceGeneratorState,
            diceCount: Binding<Int>
//            diceRoll: Binding<DiceRoll>
        ) {
//            self.diceGeneratorState = diceGeneratorState
            self._diceCount = diceCount
//            self._diceRoll = diceRoll
            
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
//        guard let managedObjectContext = diceRoll.managedObjectContext else {
//            preconditionFailure()
//        }
            
        return Publishers.CombineLatest(
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
