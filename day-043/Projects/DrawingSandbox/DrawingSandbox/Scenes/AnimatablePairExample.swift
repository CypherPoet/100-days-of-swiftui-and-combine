//
//  AnimatablePairExample.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//

import SwiftUI


struct AnimatablePairExample: View {
    @State private var rowCount: CGFloat = 3.0
    @State private var columnCount: CGFloat = 3.0
}


// MARK: - Body
extension AnimatablePairExample {

    var body: some View {
        VStack {
            Checkerboard(rowCount: Int(rowCount), columnCount: Int(columnCount))
                .fill(Color.pink)
                .animation(.easeOut(duration: 2.6))
            
            boardControls
                .padding()
        }
    }
}


// MARK: - Computeds
extension AnimatablePairExample {


}


// MARK: - View Variables
extension AnimatablePairExample {
    
    private var boardControls: some View {
        VStack(spacing: 22.0) {
            
            VStack(spacing: 8) {
                Text("Row Count")
                
                Slider(value: $rowCount, in: 1...50, minimumValueLabel: Text("1"), maximumValueLabel: Text("50")) {
                    Text("Row Count")
                }
                .labelsHidden()
            }
        
            VStack(spacing: 8) {
                Text("Column Count")
                
                Slider(value: $columnCount, in: 1...50, minimumValueLabel: Text("1"), maximumValueLabel: Text("50")) {
                    Text("Column Count")
                }
                .labelsHidden()
            }
        }
    }
}



// MARK: - Preview
struct AnimatablePairExample_Previews: PreviewProvider {

    static var previews: some View {
        AnimatablePairExample()
    }
}
