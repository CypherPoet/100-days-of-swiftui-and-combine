//
//  UIImagePickerWrapper+Coordinator.swift
//  PlaceCase
//
//  Created by CypherPoet on 1/6/20.
// ✌️
//

import Foundation
import UIKit


extension UIImagePickerWrapper {

    class Coordinator: NSObject {
        let onSelect: ((UIImage) -> Void)
        
        init(onSelect: @escaping ((UIImage) -> Void)) {
            self.onSelect = onSelect
        }
    }
}


// MARK: - UIImagePickerControllerDelegate
extension UIImagePickerWrapper.Coordinator: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let selectedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            fatalError()
        }
        
        onSelect(selectedImage)
    }
}

// MARK: - UINavigationControllerDelegate
extension UIImagePickerWrapper.Coordinator: UINavigationControllerDelegate {}
