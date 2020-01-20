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
    let card: Card
    let distanceToDragForRemoval: CGFloat
    
    var horizontalSensitivity: CGFloat = 1.0
    var verticalSensitivity: CGFloat = 0.0
    
    var onRemove: ((Card) -> Void)? = nil
    
    
    @GestureState private var dragOffset = CGSize.zero
}


// MARK: - View
extension DraggableCardView: View {

    var body: some View {
        CardView(viewModel: .init(card: card))
            .rotationEffect(cardRotation)
            .offset(cardOffset)
            .opacity(cardOpacity)
            .gesture(dragGesture)
    }
}


// MARK: - Computeds
extension DraggableCardView {
    
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
        let dragAmount = Double(abs(dragOffset.width))
        let threshold = Double(distanceToDragForRemoval / 2)
        
        guard dragAmount > threshold else { return 1.0 }

        return 1 - ((dragAmount - threshold) / (threshold * 7))
    }
}


// MARK: - View Variables
extension DraggableCardView {
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($dragOffset, body: { (newValue, offsetState, _) in
                offsetState = newValue.translation
            })
//            .onChanged { value in
//                self.dragOffset = value.translation
//            }
            .onEnded { value in
//                print("value translation: \(value.translation)")
//                print("dragOffset: \(self.dragOffset)")
                if abs(value.translation.width) > self.distanceToDragForRemoval {
                    self.onRemove?(self.card)
//                } else {
//                    self.dragOffset = .zero
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
