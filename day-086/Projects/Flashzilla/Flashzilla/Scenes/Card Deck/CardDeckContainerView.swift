//
//  CardDeckContainerView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct CardDeckContainerView {
    @ObservedObject var viewModel: ViewModel
    
    @State private var isShowingEditView = false
}


// MARK: - View
extension CardDeckContainerView: View {

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 32) {
                    
                    if self.viewModel.isTimeExpired {
                        self.timeExpirationDisplay
                    } else {
                        // 📝
                        // It can be tricky having `CardDeckContainerView` contain the timer,
                        // because SwiftUI will re-render it on every tick.
                        // 
                        // Perhaps it would be better to have `CountdownTimerView` own its timer
                        // and drive it with `timeRemaining`?
                        CountdownTimerView(
                            viewModel: .init(timeRemaining: self.viewModel.timeRemaining)
                        )
                    
                        CardDeckView(
                            width: min(max(800, geometry.size.width) * 0.8, 480),
                            height: min(max(800, geometry.size.width) * 0.8, 480) * 0.5,
                            cards: self.viewModel.visibleCards,
                            cardAnswered: { (answerState, index) in
                                self.viewModel.record(answerState, forCardAt: index)
                            }
                        )
                    }
                }
                    
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        if self.viewModel.isDeckEmpty || self.viewModel.isTimeExpired {
                            self.resetButton
                        } else {
                            self.editDeckButton
                        }
                    }
                }
            }
        }
        .padding()
        .padding()
        .background(Color("CardDeckBackground"))
        .edgesIgnoringSafeArea(.all)
        .sheet(
            isPresented: self.$isShowingEditView,
            onDismiss: {
                self.viewModel.fetchCards()
                self.viewModel.resumeRound()
            }
        ) {
            EditDeckView(
                viewModel: .init(currentDeck: self.viewModel.cardDeck)
            )
        }
        .onAppear {
            self.viewModel.isTimerActive = true
        }
    }
}


// MARK: - Computeds
extension CardDeckContainerView {
}


// MARK: - View Variables
extension CardDeckContainerView {
    
    private var timeExpirationDisplay: some View {
        VStack {
            Text("Your time has expired.")
                .font(.largeTitle)
                .foregroundColor(Color("Accent3"))
                .offset(y: -32)
            
            Text("Round Summary")
                .font(.title)
                .padding(.bottom, 24)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("✅   ") + Text(viewModel.correctAnswerCountText)
                Text("🚫  ") + Text(viewModel.incorrectAnswerCountText)
                Text("🤷‍♂️   ") + Text(viewModel.unansweredCountText)
            }
        }
    }
    
    
    private var editDeckButton: some View {
        Button(action: {
            self.viewModel.pauseRound()
            self.isShowingEditView = true
        }) {
            Image(systemName: "pencil")
                .padding()
                .background(Color("Accent1"))
                .clipShape(Capsule())
                .foregroundColor(.primary)
        }
    }
    
    
    private var resetButton: some View {
        Button("Start Again", action: viewModel.resetDeck)
            .padding()
            .background(Color("Accent1"))
            .foregroundColor(.primary)
            .clipShape(Capsule())
    }
}


// MARK: - Private Helpers
private extension CardDeckContainerView {
}



// MARK: - Preview
struct CardDeckContainerView_Previews: PreviewProvider {

    static var previews: some View {
        CardDeckContainerView(
            viewModel: .init(cardDeck: PreviewData.CardDecks.default)
        )
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
//            .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
