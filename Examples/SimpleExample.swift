//
//  SwiftUIView.swift
//  
//
//  Created by Brett Koster on 3/31/23.
//

import SwiftUI

struct SimpleExample: View {
    @State private var selectedImage: UIImage?
    
    var body: some View {
            CameraView(image: $selectedImage) {
                Label(selectedImage == nil ? "Take a Photo" : "Retake Photo", image: "Camera")
            }
        }
    }
}
