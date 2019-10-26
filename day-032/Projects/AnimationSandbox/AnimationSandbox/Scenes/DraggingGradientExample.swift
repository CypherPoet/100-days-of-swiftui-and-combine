//
//  GestureGradientView.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


struct DraggingGradientExample: View {
    @State private var dragAmount: CGSize = .zero
}


// MARK: - Body
extension DraggingGradientExample {

    var body: some View {
        
        rectangleGradient
            .frame(width: 320, height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ dragState in
                        self.dragAmount = dragState.translation
                    })
                    .onEnded( { _ in
                        withAnimation(.spring(), {
                            self.dragAmount = .zero
                        })
                    })
            )
    }
}
    

// MARK: - View Variables
extension DraggingGradientExample {
    
    private var rectangleGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [.pink, .purple, .blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}


// MARK: - Preview
struct GestureGradientView_Previews: PreviewProvider {

    static var previews: some View {
        DraggingGradientExample()
    }
}
