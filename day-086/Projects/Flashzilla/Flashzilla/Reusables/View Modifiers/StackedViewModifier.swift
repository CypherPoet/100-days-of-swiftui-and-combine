//
//  stacked.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI


struct Stacked {
    var position: Int
    var stackSize: Int
    var offsetMultiple: CGFloat = 10.0
}


// MARK: - Animatable Data
extension Stacked {
}


// MARK: - ViewModifier
extension Stacked: ViewModifier {

    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: yOffset)
    }
}



// MARK: - Computeds
extension Stacked {
    
    var yOffset: CGFloat {
        CGFloat(stackSize - position) * offsetMultiple
    }
}


// MARK: - Preview
struct Stacked_Previews: PreviewProvider {

    static var previews: some View {
        EmptyView()
    }
}
