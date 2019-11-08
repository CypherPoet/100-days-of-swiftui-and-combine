//
//  Arrow.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//


import SwiftUI
import Clamping


struct Arrow {
        
    @Clamping(range: 0.001...1.0)
    var baseWidthPct: CGFloat = 0.5
    
    @Clamping(range: 0.001...1.0)
    var baseHeightPct: CGFloat = 0.7
}


// MARK: - AnimatableData
extension Arrow {

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(baseWidthPct, baseHeightPct) }
        set {
            baseWidthPct = newValue.first
            baseHeightPct = newValue.second
        }
    }
}


// MARK: - Shape
extension Arrow: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let baseTopY = self.baseTopY(in: rect)
        let baseWidth = self.baseWidth(in: rect)

        // Arrow head points
        let arrowHeadBottomLeft = CGPoint(x: rect.minX, y: baseTopY)
        let arrowHeadTop = CGPoint(x: rect.minX + (rect.width / 2), y: rect.minY)
        let arrowHeadBottomRight = CGPoint(x: rect.maxX, y: baseTopY)
        
        // Base points
        let baseTopRight = CGPoint(x: rect.midX + (baseWidth / 2), y: baseTopY)
        let baseBottomRight = CGPoint(x: rect.midX + (baseWidth / 2), y: rect.maxY)
        let baseBottomLeft = CGPoint(x: rect.midX - (baseWidth / 2), y: rect.maxY)
        let baseTopLeft = CGPoint(x: rect.midX - (baseWidth / 2), y: baseTopY)
        
        path.move(to: arrowHeadBottomLeft)
        
        path.addLine(to: arrowHeadTop)
        path.addLine(to: arrowHeadBottomRight)
        
        path.addLine(to: baseTopRight)
        path.addLine(to: baseBottomRight)
        path.addLine(to: baseBottomLeft)
        path.addLine(to: baseTopLeft)
        
        path.addLine(to: arrowHeadBottomLeft)
        
        return path
    }
}


// MARK: - Computeds
extension Arrow {
    
    func baseTopY(in rect: CGRect) -> CGFloat {
        rect.height * (1 - baseHeightPct)
    }
    
    func baseWidth(in rect: CGRect) -> CGFloat {
        rect.width * baseWidthPct
    }
}


// MARK: - Private Helpers
extension Arrow {
}
