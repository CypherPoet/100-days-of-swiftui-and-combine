//
//  NestedGesturesExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/17/20.
// ✌️
//

import SwiftUI


struct NestedGesturesExample {
    @State private var rectangleColor = Color.orange
}


// MARK: - View
extension NestedGesturesExample: View {

    var body: some View {

        VStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(rectangleColor)
                        .frame(width: 180, height: 40)
                
                        Text("Inner")
                            .onTapGesture {
                                self.toggleRectangleColor()
                            }
                }

                VStack {
                    Text("Outer")
                }
            }
            
            Spacer()
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(rectangleColor)
                        .frame(width: 180, height: 40)
                
                        Text("Inner")
                            .onTapGesture {
                                self.rectangleColor = .purple
                            }
                }

                VStack {
                    Text("High-Priority Outer")
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { self.toggleRectangleColor() }
                        )
                }
            }
            
            Spacer()
            
            VStack {
                Text("Simultaneous Gesture")
                    .onTapGesture { self.toggleRectangleColor() }
            }
            .background(
                Rectangle()
                    .fill(rectangleColor)
                    .frame(width: 180, height: 40)
            )
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        print("Simultaneous Tap!")
                    }
            )
        }
        .padding(.vertical, 100)
    }
}


// MARK: - Computeds
extension NestedGesturesExample {
}


// MARK: - View Variables
extension NestedGesturesExample {
}


// MARK: - Private Helpers
private extension NestedGesturesExample {
    
    func toggleRectangleColor() {
        rectangleColor = rectangleColor == .orange ? .purple : .orange
    }
}



// MARK: - Preview
struct NestedGesturesExample_Previews: PreviewProvider {

    static var previews: some View {
        NestedGesturesExample()
    }
}
