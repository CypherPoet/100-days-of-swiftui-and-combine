//
//  CustomShapesExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct CustomShapesExample: View {
    private let shapeSize: CGSize = .init(width: 200, height: 200)
    private let strokeStyle = StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
}


// MARK: - Computeds
extension CustomShapesExample {


}


// MARK: - Body
extension CustomShapesExample {

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20.0) {
                Triangle()
                    .fill(Color.accentColor)
                    .frame(width: shapeSize.width, height: shapeSize.height)
                
                Triangle()
                    .strokeBorder(Color.purple, style: strokeStyle)
                    .frame(width: shapeSize.width, height: shapeSize.height)
                
                Arc(
                    startAngle: .radians(0),
                    endAngle: .radians(.pi * 1.5),
                    isClockwise: false
                )
                    .strokeBorder(Color.pink, style: strokeStyle)
                    .frame(width: shapeSize.width, height: shapeSize.height)
                
                
                Arc(
                    startAngle: .radians(0),
                    endAngle: .radians(.pi * 1.5),
                    isClockwise: true,
                    startsFromTop: true
                )
                    .strokeBorder(Color.yellow, style: strokeStyle)
                    .frame(width: shapeSize.width, height: shapeSize.height)
                
            }
        }
        .navigationBarTitle("Triangle Shape")
    }
}


// MARK: - View Variables
extension CustomShapesExample {


}



// MARK: - Preview
struct TriangleShapeExample_Previews: PreviewProvider {

    static var previews: some View {
        CustomShapesExample()
    }
}
