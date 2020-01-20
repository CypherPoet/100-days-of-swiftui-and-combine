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
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @ObservedObject var viewModel: ViewModel = .init()
}


// MARK: - View
extension CardDeckContainerView: View {

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Text("Time Remaining: \(self.viewModel.timeRemaining)")
                        .font(.largeTitle)
                        .foregroundColor(Color.yellow)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(Capsule().fill(Color.black).opacity(0.7))
                    
                    
                    CardDeckView(
                        width: min(max(800, geometry.size.width) * 0.8, 480),
                        height: min(max(800, geometry.size.width) * 0.8, 480) * 0.5,
                        cards: self.viewModel.cards,
                        onRemove: { (card, index) in self.cardRemoved(at: index) }
                    )
                    .allowsHitTesting(self.viewModel.timeRemaining > 0)
                    .padding()
                }
                
                if self.differentiateWithoutColor {
                    VStack {
                        Spacer()

                        self.swipeDirectionIndicators
                    }
                }
            }
        }
        .padding()
        .background(Color("CardDeckBackground"))
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Computeds
extension CardDeckContainerView {
}


// MARK: - View Variables
extension CardDeckContainerView {
    
    private var swipeDirectionIndicators: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            
            Spacer()
            
            
            Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        
    }
}




// MARK: - Private Helpers
private extension CardDeckContainerView {
    func cardRemoved(at index: Int) {
        viewModel.cards.remove(at: index)
    }
}



// MARK: - Preview
struct CardDeckContainerView_Previews: PreviewProvider {

    static var previews: some View {
        CardDeckContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
//            .environment(\.accessibilityDifferentiateWithoutColor, .constant(true))
            .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
