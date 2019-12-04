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
    
    @Environment(\.presentationMode) var presentationMode
    
    let onSelect: ((UIImage) -> Void)
}


// MARK: - UIViewControllerRepresentable
extension UIImagePickerWrapper: UIViewControllerRepresentable {
    
    func makeCoordinator() -> UIImagePickerWrapper.Coordinator {
        Self.Coordinator(onSelect: self.imageSelected(_:))
    }
    
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<UIImagePickerWrapper>
    ) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    
    func updateUIViewController(
        _ imagePickerController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<UIImagePickerWrapper>
    ) {
        
    }
}


private extension UIImagePickerWrapper {
    
    func imageSelected(_ image: UIImage) {
        onSelect(image)
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: - Preview
//struct UIImagePickerWrapper_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UIImagePickerWrapper()
//    }
//}
