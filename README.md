# SwiftUI CameraView
SwiftUI wrapper for the UIKit Camera View. 

# Scope
- CameraView handles triggering the UIKit camera view, and passing the captured UIImage back to your view
- You provide the button label
- Written assuming iOS 16, untested on iOS 15 or prior

# Setup
- You need to add this plist entry: NSCameraUsageDescription (Privacy - Camera Usage Description)
    - [NSCameraUsageDescription - Apple Documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription)

# Usage Example
@State private var selectedImage: UIImage?

var body: some View {
    CameraView(image: $selectedImage) {
        Label("Text Here", systemImage: "camera")
    }
}
