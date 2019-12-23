//
//  GameView.swift
//  WordScramble
//
//  Created by CypherPoet on 10/23/19.
// ✌️
//

import SwiftUI


struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
}


// MARK: - Body
extension GameView {

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Choose an anagram for")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(viewModel.currentRootWord)")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.pink)
                }
                .padding()
                
                
                TextField(
                    "Enter your word",
                    text: $viewModel.currentGuess,
                    onCommit: viewModel.checkNewWord
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()

                
                Form {
                    Section(
                        header: HStack {
                            Text("Used Words")
                            Spacer()
                            Text("Current Score: \(viewModel.currentScore)")
                        }
                        .font(.headline)
                        .padding()
                    ) {
                        List(viewModel.usedWords, id: \.self) { word in
                            UsedWordListItem(word: word)
                        }
                    }
                }
            }
            .navigationBarTitle("Anagrams")
            .navigationBarItems(leading: restartButton)
            .alert(isPresented: $viewModel.shouldShowErrorAlert) {
                Alert(
                    title: Text(self.viewModel.errorTitle),
                    message: Text(self.viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}


extension GameView {
    
    var restartButton: some View {
        Button(action: viewModel.startNewRound) {
            Image(systemName: "arrow.clockwise")
            Text("Restart")
        }
    }
}


// MARK: - Preview
struct GameView_Previews: PreviewProvider {

    static var previews: some View {
        GameView(viewModel: GameViewModel(rootWords: sampleWords))
    }
}


private struct UsedWordListItem: View {
    let word: String
    
    
    var body: some View {
        HStack {
            Text(word)
            Spacer()
            Image(systemName: "\(word.count).circle")
                .imageScale(.large)
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("\(word). \(word.count) letters."))
    }
}
