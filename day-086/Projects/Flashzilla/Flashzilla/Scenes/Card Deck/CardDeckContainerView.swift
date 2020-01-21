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
    @ObservedObject var viewModel: ViewModel = .init()
    
    @State private var isShowingEditView = false
}


// MARK: - View
extension CardDeckContainerView: View {

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 32) {
                    CountdownTimerView(
                        viewModel: .init(timeRemaining: self.viewModel.timeRemaining)
                    )
                    
                    CardDeckView(
                        width: min(max(800, geometry.size.width) * 0.8, 480),
                        height: min(max(800, geometry.size.width) * 0.8, 480) * 0.5,
                        cards: self.viewModel.visibleCards,
                        cardAnswered: { (answerState, index) in self.record(answerState, forCardAt: index) }
                    )
                    .allowsHitTesting(self.viewModel.timeRemaining > 0)
                }
                    
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        if self.viewModel.isDeckEmpty {
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
        .sheet(isPresented: self.$isShowingEditView, onDismiss: self.viewModel.resumeRound) {
            EditDeckView(
                viewModel: .init(currentDeck: self.viewModel.cards)
            )
        }
    }
}


// MARK: - Computeds
extension CardDeckContainerView {
}


// MARK: - View Variables
extension CardDeckContainerView {
    
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
    
//    func countdownFinished() {
//        viewModel.pauseRound()
//    }
    

    func record(_ answerState: Card.AnswerState, forCardAt index: Int) {
        viewModel.cards[index].answerState = answerState
        
        if viewModel.isDeckEmpty {
            viewModel.pauseRound()
        }
    }
}



// MARK: - Preview
struct CardDeckContainerView_Previews: PreviewProvider {

    static var previews: some View {
        CardDeckContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
//            .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
