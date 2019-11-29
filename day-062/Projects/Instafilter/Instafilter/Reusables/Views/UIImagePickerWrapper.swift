//
//  UIImagePickerWrapper.swift
//  Instafilter
//
//  Created by CypherPoet on 11/29/19.
// ✌️
//

import SwiftUI


struct UIImagePickerWrapper {
    typealias UIViewControllerType = UIImagePickerController
    
    
}


// MARK: - UIViewControllerRepresentable
extension UIImagePickerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<UIImagePickerWrapper>
    ) -> UIImagePickerController {
        UIImagePickerController()
    }
    
    
    
    func updateUIViewController(
        _ imagePickerController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<UIImagePickerWrapper>
    ) {
        
    }
}




// MARK: - Preview
struct UIImagePickerWrapper_Previews: PreviewProvider {

    static var previews: some View {
        UIImagePickerWrapper()
    }
}
