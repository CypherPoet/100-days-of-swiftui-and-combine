//
//  MainView.swift
//  GuessTheFlag
//
//  Created by Brian Sipple on 10/13/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var flagGame: FlagGame
    
    @State private var isShowingAlert = false
    @State private var answerWasCorrect = false
    
    @State private var backgroundGradientColors: [Color] = [
        .white, .blue, .gray
    ]
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: backgroundGradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 36) {
                VStack {
                    Text("Tap the flag of:")
                        .font(.headline)
                    Text(flagGame.flagToGuess!.cityName)
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                .foregroundColor(.black)
                
                
                ForEach(0 ..< flagGame.flagChoices.count) { index in
                    FlagButton(
                        flag: self.flagGame.flagChoices[index],
                        onTap: {
                            self.flagGame.makeGuess(with: self.flagGame.flagChoices[index]) { (wasCorrect) in
                                self.answerWasCorrect = wasCorrect
                                self.isShowingAlert = true
                                
                                if !wasCorrect {
                                    self.changeBackgroundGradientAfterWrongAnswer()
                                }
                            }
                        }
                    )
                    .rotation3DEffect(
                        .radians(self.flagGame.flagRotations[index]),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity(self.flagGame.flagOpacities[index])
                }
                
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Current Score:")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("\(flagGame.currentScore)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(.yellow)

                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("City Flags")
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text(self.alertTitle),
                message: Text(self.alertMessage),
                dismissButton: .default(
                    Text("Continue"),
                    action: {
                        if self.flagGame.latestChoiceWasCorrect {
                            self.performVictorySpin()
                        } else {
                            self.refreshBackgroundGradient()
                            self.flagGame.incrementRound()
                        }
                    }
                )
            )
        }
    }
}


// MARK: Computeds
extension MainView {
    private var alertTitle: String { answerWasCorrect ? "Correct 👏" : "Sorry" }

    
    private var alertFeedbackLine: String {
        guard
            let latestChoice = flagGame.latestChoice,
            !answerWasCorrect
        else { return "" }
        
        return "That's the flag of \(latestChoice.cityName)\n"
    }
    
    
    private var alertMessage: String {
        let scoreLine = "Your score is now \(flagGame.currentScore)"
        
        return "\(alertFeedbackLine)\(scoreLine)"
    }
}



// MARK: - Private Helpers
extension MainView {
    
    private func performVictorySpin() {
        guard
            let latestChoice = flagGame.latestChoice,
            let indexToSpin = flagGame.flagChoices.firstIndex(of: latestChoice)
        else {
            fatalError("No flag found for spinning")
        }
        
        let spinDuration = 0.4
        let spinAnimation = Animation.easeInOut(duration: spinDuration)
        
        withAnimation(spinAnimation) {
            self.flagGame.flagRotations[indexToSpin] += 2 * .pi
            
            for (index, flag) in self.flagGame.flagChoices.enumerated() {
                if flag != latestChoice {
                    self.flagGame.flagOpacities[index] = 0.2
                } else {
                    self.flagGame.flagOpacities[index] = 1.0
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + (spinDuration + 0.6)) {
            self.flagGame.incrementRound()
        }
    }
    
    
    private func refreshBackgroundGradient() {
        backgroundGradientColors[0] = .white
        backgroundGradientColors[1] = .blue
        backgroundGradientColors[2] = .gray
    }
    
    
    private func changeBackgroundGradientAfterWrongAnswer() {
        backgroundGradientColors[0] = .gray
        backgroundGradientColors[1] = .red
        backgroundGradientColors[2] = .gray
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(flagGame: FlagGame())
    }
}

