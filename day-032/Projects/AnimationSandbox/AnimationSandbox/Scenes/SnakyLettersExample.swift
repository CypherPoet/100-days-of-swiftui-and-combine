//
//  SnakyLettersExample.swift
//  AnimationSandbox
//
//  Created by CypherPoet on 10/26/19.
// ✌️
//

import SwiftUI


struct SnakyLettersExample: View {
    private let letters = Array("ANIMATION")
    
    @State private var dragOffset: CGSize = .zero
    @State private var letterBoxColor: Color = .orange
}


// MARK: - Body
extension SnakyLettersExample {

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< letters.count) { index in
                Text(String(self.letters[index]))
                    .padding()
                    .font(.headline)
                    .background(self.letterBoxColor)
                    .offset(self.dragOffset)
                    .animation(
                        Animation
                            .easeOut(duration: 0.5)
                            .delay(0.1 * Double(index))
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragState in
                    self.dragOffset = dragState.translation
                })
                .onEnded({ _ in
                    self.dragOffset = .zero
                    self.letterBoxColor = self.letterBoxColor == .purple ? .orange : .purple
                })
        )
    }
}


// MARK: - View Variables
extension SnakyLettersExample {
}


// MARK: - Preview
struct SnakyLettersExample_Previews: PreviewProvider {

    static var previews: some View {
        SnakyLettersExample()
    }
}
