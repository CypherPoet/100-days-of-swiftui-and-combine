//
//  GameContainerView.swift
//  WordScramble
//
//  Created by CypherPoet on 10/22/19.
// ✌️
//

import SwiftUI


struct GameContainerView: View {
    @ObservedObject var gameViewModel = GameViewModel()
}


// MARK: - Body
extension GameContainerView {

    var body: some View {
        GameView(viewModel: gameViewModel)
            .onAppear {
                self.loadWords()
            }
    }
}


// MARK: - Private Helpers
extension GameContainerView {
    
    private func loadWords() {
        Bundle.main.createString(fromFileNamed: "game-words", withExtension: "txt") { result in
            switch result {
            case .success(let string):
                self.gameViewModel.allRootWords = string.components(separatedBy: "\n")
                self.gameViewModel.startNewRound()
            case .failure:
                fatalError()
            }
        }
    }
}


// MARK: - Preview
struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        return GameContainerView(gameViewModel: GameViewModel(rootWords: sampleWords))
    }
}
