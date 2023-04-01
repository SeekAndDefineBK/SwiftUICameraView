//
//  SwiftUIView.swift
//  
//
//  Created by Brett Koster on 3/31/23.
//

import SwiftUI
import SwiftUICameraView

struct SimpleExample: View {
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let unwrappedImage = selectedImage {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .scaledToFit()
                CameraView(image: $selectedImage) {
                    Label("Capture a Different Photo", image: "Camera")
                }
                
            } else {
                Label("Capture a Photo", image: "Camera")
            }
        }
        
    }
}
