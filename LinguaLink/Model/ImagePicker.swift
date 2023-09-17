//
//  ImagePicker.swift
//  LinguaLink
//
//  Created by Yangru Guo on 11/9/2023.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    // Used for binging up phone camera and capturing picture for translation
    
    @Binding var image: UIImage?
    
    // Create the UIImagePickerController and configure it
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    // This function is required by protocol but not used in this app
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    // Create a Coordinator to handle image picker events
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // Handle image selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                // Update the parent's image with the selected image
                parent.image = uiImage
            }
            
            // Dismiss the image picker view
            picker.dismiss(animated: true)
        }
        
        // Handle cancellation of image picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Dismiss the image picker view
            picker.dismiss(animated: true)
        }
    }
}
