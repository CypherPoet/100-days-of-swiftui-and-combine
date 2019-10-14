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
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.white, .blue, .gray]),
                startPoint: .top,
                endPoint: .bottom
            )
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 36) {
                VStack {
                    Text("Tap the flag of:")
                        .font(.headline)
                    Text(flagGame.flagToGuess.cityName)
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                .foregroundColor(.black)
                
                ForEach(flagGame.flagChoices) { flag in
                    Button(action: {
                        self.flagGame.makeGuess(with: flag) { (wasCorrect) in
                            self.answerWasCorrect = wasCorrect
                            self.isShowingAlert = true
                        }
                    }) {
                        Image(flag.imageName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(1.75, contentMode: .fit)
                            .clipped()
                            .cornerRadius(42)
                            .shadow(color: .purple, radius: 9, x: 0, y: -1.3)
                    }
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
                message: Text(self.alertScoreMessage),
                dismissButton: .default(
                    Text("Continue"),
                    action: {
                        self.flagGame.incrementRound()
                    }
                )
            )
        }
    }
}


extension MainView {
    var alertTitle: String { answerWasCorrect ? "Correct 👏" : "Sorry" }

    
    var alertScoreMessage: String {
        let feedbackLine = answerWasCorrect ?
            ""
            : "That's not the flag of \(flagGame.flagToGuess.cityName)\n"
        
        let scoreLine = "Your score is now \(flagGame.currentScore)"
        
        return "\(feedbackLine)\(scoreLine)"
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(flagGame: FlagGame())
    }
}
