//
//  GestureSequencingExample.swift
//  Project17Concepts
//
//  Created by CypherPoet on 1/17/20.
// ✌️
//

import SwiftUI


struct GestureSequencingExample {
    @GestureState private var dragSequenceState: DragSequenceState = .inactive
}


// MARK: - View
extension GestureSequencingExample: View {

    var body: some View {
        VStack(spacing: 42) {
            Text("Drag the Circle (After Long Pressing First!)")
                .font(.headline)
            
            Circle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .scaleEffect(dragSequenceState.currentScale)
                .offset(dragSequenceState.currentOffset)
                .gesture(longPressDragGesture)
                .animation(Animation.easeOut(duration: 0.2))
        }
    }
}


// MARK: - Computeds
extension GestureSequencingExample {
}


// MARK: - View Variables
extension GestureSequencingExample {
    
    var longPressDragGesture: some Gesture {
        SequenceGesture(circleLongPress, circleDrag)
            .updating($dragSequenceState) { value, state, transation  in
                switch value {
                case .first(_):
                    // User is pressing on the screen
                    state = .longPressing
                case .second(_, let dragValue):
                    // User is still pressing after long press happened
                    state = .dragging(translation: dragValue?.translation ?? CGSize.zero)
                }
            }
    }

    
    var circleLongPress: LongPressGesture {
        LongPressGesture(minimumDuration: 1)

    }
        

    var circleDrag: DragGesture {
        DragGesture()
    }
}


// MARK: - Private Helpers
private extension GestureSequencingExample {
}


extension GestureSequencingExample {
    enum DragSequenceState {
        case inactive
        case longPressing
        case dragging(translation: CGSize)
        
        
        var currentScale: CGFloat {
            switch self {
            case .inactive:
                return 1.0
             case .longPressing:
                return 0.8
            case .dragging(_)   :
                return 1.2
            }
        }
        
        var currentOffset: CGSize {
            switch self {
            case .inactive,
                 .longPressing:
                return .zero
            case .dragging(let offset):
                return offset
            }
        }
    }
}



// MARK: - Preview
struct GestureSequencingExample_Previews: PreviewProvider {

    static var previews: some View {
        GestureSequencingExample()
    }
}
