//
//  RadialFlower.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//


import SwiftUI


struct RadialFlower {
    var petalWidth: CGFloat = 100.0

    var petalCount: Int = 16
    
    /// How much to move this petal away from the center
    var petalOffset: CGFloat = -20.0
}



// MARK: - Shape
extension RadialFlower: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        

        for radians in stride(
            from: 0,
            to: CGFloat.pi * 2,
            by: CGFloat(rotationIncrement.radians)
        ) {
            let rotation = CGAffineTransform(rotationAngle: radians)
            
            let position = rotation.concatenating(
                CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2)
            )
            
            let rotatedPetal = basePetal(in: rect).applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}


// MARK: - Computeds
extension RadialFlower {
    
    private var rotationIncrement: Angle {
        .radians((2 * .pi) / Double(petalCount))
    }
}


// MARK: - Private Helpers
extension RadialFlower {
    
    private func basePetal(in rect: CGRect) -> Path {
        let petalHeight = rect.width / 2
        
        return Path(ellipseIn:
            CGRect(
                x: petalOffset,
                y: 0,
                width: petalWidth,
                height: petalHeight
            )
        )
    }
}
