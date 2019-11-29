//
//  UIImagePickerWrapper+Coordinator.swift
//  Instafilter
//
//  Created by CypherPoet on 11/29/19.
// ✌️
//

import Foundation
import UIKit
import SwiftUI


extension UIImagePickerWrapper {
    
    class Coordinator: NSObject {
        let onSelect: ((UIImage?) -> Void)
        
        init(onSelect: @escaping ((UIImage?) -> Void)) {
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
        let selectedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        
        onSelect(selectedImage)
    }
}



// MARK: - UINavigationControllerDelegate
extension UIImagePickerWrapper.Coordinator: UINavigationControllerDelegate {}
