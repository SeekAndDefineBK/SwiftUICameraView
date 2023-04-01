//
//  ImagePickerDelegate.swift
//  
//
//  Created by Brett Koster on 4/1/23.
//

import SwiftUI
import UIKit

// This is a custom delegate class which contains a reference to the CameraView parent view
public class ImagePickerDelegate<Content: View>: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public let parent: CameraView<Content>
    
    // We'll store a reference to the parent view in this property, so that we can update the image state variable
    public init(parent: CameraView<Content>) {
        self.parent = parent
    }

    // This method is called when the user captures an image in the UIImagePickerController
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get the captured image
        if let image = info[.originalImage] as? UIImage {
            // Set the image state variable to the captured image
            parent.image = image
        }
        
        // Dismiss the UIImagePickerController when user completes interaction
        picker.dismiss(animated: true, completion: nil)
    }
}
