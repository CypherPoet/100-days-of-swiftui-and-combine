//
//  TrianglePathExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/5/19.
// ✌️
//

import SwiftUI


struct TrianglePathExample: View {
}


// MARK: - Computeds
extension TrianglePathExample {


}


// MARK: - Body
extension TrianglePathExample {

    var body: some View {
        VStack {
            trianglePath
        }
        .navigationBarTitle("Triangle Path")
    }
}


// MARK: - View Variables
extension TrianglePathExample {

    private var trianglePath: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 300, y: 300))
        }
//        .fill(Color.accentColor)
//            .stroke(Color.accentColor, lineWidth: 10)
            .stroke(Color.pink, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)) // 👍
    }

}



// MARK: - Preview
struct TrainglePathExample_Previews: PreviewProvider {

    static var previews: some View {
        TrianglePathExample()
            .accentColor(.pink)
    }
}
