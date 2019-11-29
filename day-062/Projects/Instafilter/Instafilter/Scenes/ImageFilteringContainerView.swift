//
//  ImageFilteringContainerView.swift
//  Instafilter
//
//  Created by CypherPoet on 11/28/19.
// ✌️
//

import SwiftUI


struct ImageFilteringContainerView: View {
    @State private var currentInputImage: UIImage? = nil
    @State private var isShowingImagePicker = false
}


// MARK: - Body
extension ImageFilteringContainerView {

    var body: some View {
        VStack(spacing: 42.0) {
            Spacer()
            
            imageContent
                .layoutPriority(1)
            
            imagePickerButton
            
            Spacer()
        }
        .sheet(isPresented: $isShowingImagePicker) {
            UIImagePickerWrapper(selectedImage: self.$currentInputImage)
        }
    }
}


// MARK: - Computeds
extension ImageFilteringContainerView {


}


// MARK: - View Variables
extension ImageFilteringContainerView {
    
    private var imageContent: some View {
        Group {
            if currentInputImage != nil {
                ImageFilteringView(inputImage: currentInputImage!)
            } else {
                Text("Select an Image to begin filtering.")
                    .font(.title)
            }
        }
    }
    
    private var imagePickerButton: some View {
        Button(action: {
            self.isShowingImagePicker = true
        }) {
            Image(systemName: "camera.fill")
                .renderingMode(.original)
                .colorInvert()
                .scaleEffect(2)
        }
        .frame(minWidth: 80, minHeight: 40)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 8, x: 0, y: 0)
    }
}


// MARK: - Private Helpers
private extension ImageFilteringContainerView {
    
    func selectImage() {
        
    }
}


// MARK: - Preview
struct ImageFilteringContainerView_Previews: PreviewProvider {

    static var previews: some View {
        ImageFilteringContainerView()
    }
}
