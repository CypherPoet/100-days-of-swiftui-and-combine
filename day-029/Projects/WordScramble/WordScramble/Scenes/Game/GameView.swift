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
                    .padding()
                
                List(viewModel.usedWords, id: \.self) { word in
                    Text(word)
                    Spacer()
                    Image(systemName: "\(word.count).circle")
                        .imageScale(.large)
                }
            }
            .navigationBarTitle("Anagrams")
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


// MARK: - Preview
struct GameView_Previews: PreviewProvider {

    static var previews: some View {
        GameView(viewModel: GameViewModel(rootWords: sampleWords))
    }
}
