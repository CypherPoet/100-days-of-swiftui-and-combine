//
//  SideScrollingRectangleFlowView.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/24/20.
// ✌️
//

import SwiftUI


struct SideScrollingRectangleFlowView {
    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    let container: GeometryProxy
}


// MARK: - View
extension SideScrollingRectangleFlowView: View {
    
    var body: some View {
        HStack {
            ForEach(0 ..< 50) { index in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(self.colors[index % self.colors.count])
                        .frame(height: 150)
                        .rotation3DEffect(
                            self.rotation(forRectWith: geometry),
                            axis: (x: 0, y: 1, z: 0)
                        )
                }
                .frame(width: 150)
            }
        }
        .padding(.horizontal, (container.size.width - 150) / 2)
    }
}


// MARK: - Private Helpers
private extension SideScrollingRectangleFlowView {
    
    func rotation(forRectWith geometry: GeometryProxy) -> Angle {
        let screenMidX = Double(geometry.frame(in: .global).midX)
        let containerHalfWidth = Double(container.size.width / 2)
            
        return .radians(
            -1 * ((screenMidX - containerHalfWidth) / 10 / 180) * Double.pi
        )
    }
}

// MARK: - Preview
struct SideScrollingRectangleFlowView_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                SideScrollingRectangleFlowView(container: geometry)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
