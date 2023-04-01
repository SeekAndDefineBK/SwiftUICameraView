//
//  CameraView.swift
//
//
//  Created by Brett Koster on 4/1/23.
//

import SwiftUI

public struct CameraView<Content: View>: View {
    // The captured image, this cannot be private due to being shared with ImagePickerDelegate
    @Binding var image: UIImage?
    
    // We'll store the ImagePickerDelegate instance in this property to ensure that it's not deallocated prematurely
    @State private var imagePickerDelegate: ImagePickerDelegate<Content>?
    
    // The SwiftUI view passed in to display as the button label
    var label: () -> Content
    
    /// Default initializer that requires a bound UIImage? object and a SwiftUI view for the button label
    /// - Parameters:
    ///   - image: Binding<UIImage?>
    ///   - label: SwiftUI view that will serve as the button label
    public init(image: Binding<UIImage?>, label: @escaping () -> Content) {
        _image = image
        self.label = label
    }
    
    public var body: some View {
        Button {
            capturePhoto()
        } label: {
            label()
        }
    }

    public func capturePhoto() {
        // Create an instance of UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        // Create an instance of ImagePickerDelegate and store it in the imagePickerDelegate property
        imagePickerDelegate = ImagePickerDelegate<Content>(parent: self)
        
        // Set the delegate of the UIImagePickerController to the ImagePickerDelegate instance
        imagePicker.delegate = imagePickerDelegate
        
        // Set the source type of the UIImagePickerController to the camera
        imagePicker.sourceType = .camera
    
        // Verify UIWindowScene exists
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        // Verify Window in UIWindowScene exists
        guard let firstWindow = firstScene.windows.first else {
            return
        }
        
        // Present the UIImagePickerController
        if let viewController = firstWindow.rootViewController {
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
}
