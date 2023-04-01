import SwiftUI
import PhotosUI
import UIKit

@available(iOS 16.0, *)
struct CameraView<Content: View>: UIViewControllerRepresentable {
    //MARK: ViewController properties
    @Binding var image: UIImage?
    let swiftUIView: UIHostingController<Content>
    
    /// Use this initializer when you have a SwiftUI view to trigger the camera
    /// - Parameters:
    ///   - image: Binding object that will receive the new image when available
    ///   - swiftUIView: SwiftUI View that will represent the camera button
    init(image: Binding<UIImage?>, swiftUIView: @escaping () -> Content) {
        _image = image
        self.swiftUIView = UIHostingController(rootView: swiftUIView())
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return CameraViewController(
            image: $image,
            swiftUIView: swiftUIView
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //Unused at this point, but required for protocol conformance
    }
}

@available(iOS 16.0, *)
class CameraViewController<Content: View>: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    var hostingController: UIHostingController<Content>
    
    init(image: Binding<UIImage?>, swiftUIView: UIHostingController<Content>) {
        _image = image
        hostingController = swiftUIView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SwiftUICameraView failed to load, NSCoder: \(coder)")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let child: UIView = hostingController.view
        child.translatesAutoresizingMaskIntoConstraints = false
        child.frame = CGRect(x: 0, y: 0, width: 150, height: 50)

        NSLayoutConstraint.activate( [
            child.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            child.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let button = UIButton(type: .system)
        button.addSubview(child)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        hostingController.didMove(toParent: self)
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.image = image
    }
}
