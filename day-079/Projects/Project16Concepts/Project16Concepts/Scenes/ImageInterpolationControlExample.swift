//
//  ImageInterpolationControlExample.swift
//  Project16Concepts
//
//  Created by CypherPoet on 1/8/20.
// ✌️
//

import SwiftUI


struct ImageInterpolationControlExample: View {
}


// MARK: - Body
extension ImageInterpolationControlExample {

    var body: some View {
        VStack {
            
            // Take a close look at the edges of the colors: they look jagged, but also blurry.
            // The jagged part comes from the original image because it’s only 66x92 pixels in size,
            // but the blurry part is where SwiftUI is trying to blend the pixels as they
            // are stretched to make the stretching less obvious.

            // Often this blending works great, but it struggles here because the
            // source picture is small (and therefore needs a lot of blending to
            // be shown at the size we want), and also because the image has
            // lots of solid colors so the blended pixels stand out quite obviously.
            Image("alien")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            
            // For situations just like the one above, SwiftUI gives us the
            // interpolation() modifier that lets us control how pixel blending
            // is applied.
            Image("alien")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            
        }
    }
}


// MARK: - Computeds
extension ImageInterpolationControlExample {
}


// MARK: - View Variables
extension ImageInterpolationControlExample {
}



// MARK: - Preview
struct ImageInterpolationControlExample_Previews: PreviewProvider {

    static var previews: some View {
        ImageInterpolationControlExample()
    }
}
