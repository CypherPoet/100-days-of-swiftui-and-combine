//
//  GameView.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import SwiftUI


struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var game: Game
    
    @State private var pendingChoice: GameItem?
    @State private var answerWasCorrect = false
    @State private var isShowingGameAlert = false

    
    var body: some View {
        VStack(spacing: 60) {
            
            VStack(spacing: 14) {
                Text("Opponent: ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            
                game.currentItem.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.purple)
                    .frame(width: 200, height: 200)
            }
            
            
            VStack(spacing: 28) {
                Text("Choose to \(game.desiredOutcome.displayValue):")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                HStack(spacing: 32) {
                    optionButtons
                }
                
                shootButton
                
            }

            Spacer()
            
            statusItems
                .brightness(colorScheme == .light ? -0.3 : 0.0)
            
        }
        .foregroundColor(.purple)
        .padding()
        .background(gradientBackground.edgesIgnoringSafeArea(.all))
        .onAppear {
            self.game.startNewGame()
            self.game.currentItem = .paper
        }
        .alert(isPresented: $isShowingGameAlert) {
            self.game.currentAlert
        }
    }
}


// MARK: - Computeds
extension GameView {
    private var canShoot: Bool { pendingChoice != nil }
    
    private var gradientBackgroundColors: [Color] {
        switch colorScheme {
        case .dark:
            return [
                Color(white: 0.07),
                Color(white: 0.17),
                Color(white: 0.37),
            ]
        case .light:
            return [.white, Color.purple.opacity(0.4)]
        @unknown default:
            return [.clear, .clear]
        }
    }
}


// MARK: - View Variables
extension GameView {

    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: gradientBackgroundColors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    
    private var optionButtons: some View {
        ForEach(GameItem.allCases, id: \.self) { gameItem in
            GameOptionButton(
                gameItem: gameItem,
                opposingGameItem: self.game.currentItem,
                currentSelection: self.$pendingChoice
            )
        }
    }
    
    
    private var statusItems: some View {
        HStack(alignment: .firstTextBaseline) {
            Spacer()
            
            Text("Round:")
                + Text(" \(game.currentRound) / \(game.roundLimit)")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Score:")
            + Text(" \(game.currentScore)")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
        }
    }
    
    
    private var shootButton: some View {
        Button(action: {
            guard let choice = self.pendingChoice else {
                preconditionFailure("Button should be disabled if nothing is chosen.")
            }
            
            self.game.check(answer: choice) { _ in
                self.pendingChoice = nil
                self.isShowingGameAlert = true
            }
        }) {
            Text("Shoot!")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding()
        .padding(.horizontal)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .disabled(!canShoot)
        .opacity(canShoot ? 1.0 : 0.3)
        .animation(.easeIn(duration: 0.3))
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game())
    }
}
