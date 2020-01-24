//
//  AlignmentAndGuidesExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/23/20.
// ✌️
//

import SwiftUI


struct AlignmentAndGuidesExample {
}


// MARK: - View
extension AlignmentAndGuidesExample: View {

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Live long and prosper")
                    .background(Color.blue)
                    .frame(width: 300, height: 300, alignment: .topLeading)
            }
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            
            
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in d[.trailing] }

                Text("This is a longer line of text")
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
            
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Item \(position)")
                        .alignmentGuide(.leading, computeValue: { _ in CGFloat(position * -10) })
                }
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
        }
        
        
    }
}


// MARK: - Computeds
extension AlignmentAndGuidesExample {
}


// MARK: - View Variables
extension AlignmentAndGuidesExample {
}


// MARK: - Private Helpers
private extension AlignmentAndGuidesExample {
}



// MARK: - Preview
struct AlignmentAndGuidesExample_Previews: PreviewProvider {

    static var previews: some View {
        AlignmentAndGuidesExample()
    }
}
