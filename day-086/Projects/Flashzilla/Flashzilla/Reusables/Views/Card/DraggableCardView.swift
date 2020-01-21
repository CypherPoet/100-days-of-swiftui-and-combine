//
//  DraggableCardView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct DraggableCardView {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    let card: Card
    let distanceToDragForRemoval: CGFloat
    
    var horizontalSensitivity: CGFloat = 1.0
    var verticalSensitivity: CGFloat = 0.0
    
    var onRemove: ((Card, Card.AnswerState) -> Void)? = nil
    
    @GestureState private var dragOffset = CGSize.zero
    let feedbackGenerator = UINotificationFeedbackGenerator()
}


// MARK: - View
extension DraggableCardView: View {

    var body: some View {
        GeometryReader { geometry in
            CardView(
                viewModel: .init(card: self.card),
                cornerRadius: min(geometry.size.width, geometry.size.height) * 0.08,
                fillColorOpacity: self.cardOpacity
            )
            .background(
                self.dragColor?
                    .opacity(self.dragColorOpacity)
                    .clipShape(
                        RoundedRectangle(cornerRadius: min(geometry.size.width, geometry.size.height) * 0.08)
                    )
                    .animation(.easeIn(duration: 0.25))
            )
            .animation(nil)
            .rotationEffect(self.cardRotation)
            .offset(self.cardOffset)
            .animation(.spring())
            .gesture(self.dragGesture)
        }
    }
}


// MARK: - Computeds
extension DraggableCardView {
    
    var dragWidthAmount: Double { Double(abs(dragOffset.width)) }
    var distanceUntilRemoval: Double { Double(distanceToDragForRemoval) - dragWidthAmount }
    
    var cardOffset: CGSize {
        .init(
            width: dragOffset.width * horizontalSensitivity,
            height: dragOffset.height * verticalSensitivity
        )
    }
    
    
    var cardRotation: Angle {
        .radians((Double(dragOffset.width) / 180.0) / 2.2)
    }
    
    
    var cardOpacity: Double {
        guard differentiateWithoutColor == false else { return 1.0 }
        
        return distanceUntilRemoval / Double(distanceToDragForRemoval)
    }
    
    
    var dragColor: Color? {
        guard differentiateWithoutColor == false else { return nil }
        
        return dragOffset.width > 0 ? Color.green : Color.red
    }
    

    var dragColorOpacity: Double {
        1.0 - ( (distanceUntilRemoval / Double(distanceToDragForRemoval * 1.5)) )
    }
}


// MARK: - View Variables
extension DraggableCardView {
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($dragOffset, body: { (newValue, offsetState, _) in
                offsetState = newValue.translation
                self.feedbackGenerator.prepare()
            })
            .onEnded { value in
                if abs(value.translation.width) > self.distanceToDragForRemoval {
                    let answerState: Card.AnswerState = value.translation.width > 0 ? .correct : .incorrect
                    
                    self.onRemove?(self.card, answerState)
                    self.feedbackGenerator.notificationOccurred(.success)
                } else {
                    self.feedbackGenerator.notificationOccurred(.error)
                }
            }
    }
}


// MARK: - Private Helpers
private extension DraggableCardView {
}



// MARK: - Preview
struct DraggableCardView_Previews: PreviewProvider {

    static var previews: some View {
        DraggableCardView(
            card: PreviewData.Cards.default,
            distanceToDragForRemoval: 100
        )
        .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
        .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
