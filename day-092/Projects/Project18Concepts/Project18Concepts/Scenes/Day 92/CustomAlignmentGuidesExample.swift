//
//  CustomAlignmentGuidesExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/23/20.
// ✌️
//

import SwiftUI


struct CustomAlignmentGuidesExample {
    
    enum CustomAlignment: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            dimensions[VerticalAlignment.center]
        }
        
    }

    static let customAlignment = VerticalAlignment(CustomAlignment.self)
}


// MARK: - View
extension CustomAlignmentGuidesExample: View {

    var body: some View {
        HStack(alignment: Self.customAlignment) {
            VStack {
                Text("Twitter: @Cypher_Poet")
                    .alignmentGuide(Self.customAlignment) { dimensions in
                        dimensions[VerticalAlignment.top]
                    }
                
                Image("CypherPoet")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            Spacer()
            
            VStack {
                Text("Species")
                
                Text("HUMAN")
                    .font(.largeTitle)
                    .alignmentGuide(Self.customAlignment) { dimensions in
                        dimensions[VerticalAlignment.bottom]
                    }
                
            }
        }
        .padding(.horizontal)
    }
}


// MARK: - Computeds
extension CustomAlignmentGuidesExample {
}


// MARK: - View Variables
extension CustomAlignmentGuidesExample {
}


// MARK: - Private Helpers
private extension CustomAlignmentGuidesExample {
}



// MARK: - Preview
struct CustomAlignmentGuidesExample_Previews: PreviewProvider {

    static var previews: some View {
        CustomAlignmentGuidesExample()
    }
}
