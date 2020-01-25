//
//  SpinningHelixView.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI



struct SpinningHelixView {
    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var container: GeometryProxy
}



// MARK: - View
extension SpinningHelixView: View {
    
    var body: some View {
        ForEach(0..<50) { row in
            GeometryReader { geometry in
                Text("Row \(row)")
                    .font(.largeTitle)
                    .frame(width: self.container.size.width)
                    .background(self.colors[row % self.colors.count])
                    .rotation3DEffect(
                        self.rotation(forRowWith: geometry),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            .frame(height: 40)
        }
    }
}
    

// MARK: - Computeds
extension SpinningHelixView {
}


// MARK: - View Variables
extension SpinningHelixView {
}


// MARK: - Private Helpers
private extension SpinningHelixView {
    func rotation(forRowWith geometry: GeometryProxy) -> Angle {
        let screenHeight = Double(geometry.frame(in: .global).minY)
        let containerMidHeight = Double(container.size.height) / 2.0
        
        return .radians(
            ((screenHeight / 4 / 180) * Double.pi) - containerMidHeight
        )
    }
}



// MARK: - Preview
struct SpinningHelixView_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                SpinningHelixView(container: geometry)
            }
        }
    }
}
