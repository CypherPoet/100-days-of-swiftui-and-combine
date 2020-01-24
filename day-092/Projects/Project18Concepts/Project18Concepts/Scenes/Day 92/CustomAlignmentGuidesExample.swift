//
//  CustomAlignmentGuidesExample.swift
//  Project18Concepts
//
//  Created by CypherPoet on 1/23/20.
// ✌️
//

import SwiftUI


extension VerticalAlignment {
    enum CustomAlignment: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            dimensions[VerticalAlignment.center]
        }
        
    }

    static let customAlignment = VerticalAlignment(CustomAlignment.self)
}



struct CustomAlignmentGuidesExample {
}


// MARK: - View
extension CustomAlignmentGuidesExample: View {

    var body: some View {
        HStack(alignment: .customAlignment) {
            VStack {
                Text("Twitter: @Cypher_Poet")
                    .alignmentGuide(.customAlignment) { dimensions in
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
                    .alignmentGuide(.customAlignment) { dimensions in
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
