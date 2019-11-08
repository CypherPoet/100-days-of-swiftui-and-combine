//
//  Checkerboard.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//


import SwiftUI
import Clamping


struct Checkerboard {
    
    @Clamping(range: 1...Int.max)
    var rowCount: Int = 1
    
    @Clamping(range: 1...Int.max)
    var columnCount: Int = 1
}


// MARK: - AnimatableData
extension Checkerboard {
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(CGFloat(rowCount), CGFloat(columnCount))
        }
        set {
            rowCount = Int(newValue.first)
            columnCount = Int(newValue.second)
        }
    }
}


// MARK: - Shape
extension Checkerboard: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let columnWidth = self.columnWidth(in: rect)
        let rowHeight = self.rowHeight(in: rect)
        
        for row in 0 ..< rowCount {
            for column in 0 ..< columnCount {
                
                if (row + column).isMultiple(of: 2) {
                    // this square should be filled
                    
                    let startX = columnWidth * CGFloat(column)
                    let startY = rowHeight * CGFloat(row)
                    
                    let boardRect = CGRect(
                        x: startX,
                        y: startY,
                        width: columnWidth,
                        height: rowHeight
                    )
                    
                    path.addRect(boardRect)
                }
            }
        }
        
        return path
    }
}


// MARK: - Computeds
extension Checkerboard {
    
    func columnWidth(in rect: CGRect) -> CGFloat {
        rect.width / CGFloat(columnCount)
    }
    
    func rowHeight(in rect: CGRect) -> CGFloat {
        rect.height / CGFloat(rowCount)
    }
}
