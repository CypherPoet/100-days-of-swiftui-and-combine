//
//  ContentShapeExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/18/20.
// ✌️
//

import SwiftUI


struct ContentShapeExample {
    @State var tappedViewState: TappedViewState = .none
}


// MARK: - View
extension ContentShapeExample: View {

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Tapped View: \(tappedViewState.displayText)")
                .font(.title)

            VStack(spacing: 10) {
                Text("Circle With Rectangle Content Shape")
                    .font(.headline)
                
                ZStack {
                    Rectangle()
                        .fill(Color.purple)
                        .onTapGesture { self.tappedViewState = .rectangle }
                    
                    Circle()
                        .fill(Color.orange)
                        .onTapGesture { self.tappedViewState = .circle }
                        .padding()
                        .contentShape(Rectangle())
                }
                .frame(width: 200, height: 200)
            }
            
            VStack(spacing: 10) {
                Text("VStack with Spacer")
                    .font(.headline)
                
                VStack {
                    Rectangle()
                        .fill(Color.pink)
                        .frame(width: 200, height: 100)

                    Spacer()
                        .frame(width: 200, height: 100)

                    Rectangle()
                        .fill(Color.pink)
                        .frame(width: 200, height: 100)
                }
                .border(Color.black, width: 4)
                .contentShape(Rectangle()) // 🔑 Uncomment to have the Spacer's area be hit tested
                .onTapGesture { self.tappedViewState = .vStack }
            }

            Spacer()
        }
    }
}


// MARK: - Computeds
extension ContentShapeExample {
}


// MARK: - View Variables
extension ContentShapeExample {
}


// MARK: - Private Helpers
private extension ContentShapeExample {
}


extension ContentShapeExample {
    enum TappedViewState {
        case none
        case circle
        case rectangle
        case vStack
        
        
        var displayText: String {
            switch self {
            case .none:
                return "Nothing Yet"
            case .circle:
                return "Circle"
            case .rectangle:
                return "Rectangle"
            case .vStack:
                return "VStack"
            }
        }
    }
}



// MARK: - Preview
struct ContentShapeExample_Previews: PreviewProvider {

    static var previews: some View {
        ContentShapeExample()
    }
}
