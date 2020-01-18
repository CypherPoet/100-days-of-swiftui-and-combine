//
//  AllowsHitTestingExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/18/20.
// ✌️
//

import SwiftUI


struct AllowsHitTestingExample {
    @State var tappedShapeState: TappedShapeState = .none
}


// MARK: - View
extension AllowsHitTestingExample: View {

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Tapped Shape: \(tappedShapeState.displayText)")
                .font(.title)

            VStack(spacing: 10) {
                Text("Circle With Hit Testing")
                    .font(.headline)
                
                ZStack {
                    Rectangle()
                        .fill(Color.purple)
                        .onTapGesture { self.tappedShapeState = .rectangle }
                    
                    Circle()
                        .fill(Color.orange)
                        .onTapGesture { self.tappedShapeState = .circle }
                        .padding()
                }
                .frame(width: 200, height: 200)
            }
            
            VStack(spacing: 10) {
                Text("Circle Without Hit Testing")
                    .font(.headline)
                
                ZStack {
                    Rectangle()
                        .fill(Color.purple)
                        .onTapGesture { self.tappedShapeState = .rectangle }
                    
                    Circle()
                        .fill(Color.orange)
                        .onTapGesture { self.tappedShapeState = .circle }
                        .padding()
                        .allowsHitTesting(false)
                }
                .frame(width: 200, height: 200)
            }

            Spacer()
        }
    }
}


// MARK: - Computeds
extension AllowsHitTestingExample {
}


// MARK: - View Variables
extension AllowsHitTestingExample {
}


// MARK: - Private Helpers
private extension AllowsHitTestingExample {
}


extension AllowsHitTestingExample {
    enum TappedShapeState {
        case none
        case circle
        case rectangle
        
        
        var displayText: String {
            switch self {
            case .none:
                return "Nothing Yet"
            case .circle:
                return "Circle"
            case .rectangle:
                return "Rectangle"
            }
        }
    }
}



// MARK: - Preview
struct AllowsHitTestingExample_Previews: PreviewProvider {

    static var previews: some View {
        AllowsHitTestingExample()
    }
}
