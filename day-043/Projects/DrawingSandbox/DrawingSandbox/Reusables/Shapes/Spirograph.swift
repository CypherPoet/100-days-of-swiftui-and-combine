//
//  Spirograph.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//


import SwiftUI


struct Spirograph {
    
    /// The radius of the outer circle.
    let majorRadius: CGFloat
    
    /// The radius of the interior circle.
    let minorRadius: CGFloat
    
    /// The distance of the virtual pen from the center of the interior circle.
    let penOffset: CGFloat
    
    /// What amount of the roulette to draw
    let amount: CGFloat
}


// MARK: - AnimatableData
extension Spirograph {

    var animatableData: EmptyAnimatableData {
        .init()
    }
}


// MARK: - Shape
extension Spirograph: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let divisor = gcd(Int(minorRadius), b: Int(majorRadius))
        let deltaR = majorRadius - minorRadius
        let endPoint = ceil(2 * .pi * majorRadius / CGFloat(divisor)) * amount
        let xIncrement = rect.width / 2
        let yIncrement = rect.height / 2
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = ( cos(theta) * deltaR ) + ( penOffset * cos(deltaR * theta / minorRadius) )
            var y = ( sin(theta) * deltaR ) + ( penOffset * sin(deltaR * theta / minorRadius) )

            x += xIncrement
            y += yIncrement

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}
