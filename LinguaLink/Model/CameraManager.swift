//
//  CameraManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 11/9/2023.
//

import Foundation
import UIKit
import SwiftUI

class CameraManager: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ObservableObject {
    
    //    Used to manage camera actions and outputs
    
    @Published var isShowingImagePicker = false
    @Published var selectedImage: UIImage? = nil
    
    func showImagePicker() {
        isShowingImagePicker = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        isShowingImagePicker = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShowingImagePicker = false
    }
}
