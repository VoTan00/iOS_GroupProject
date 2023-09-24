/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/

import SwiftUI
import Foundation

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
     
    private let controller = UIImagePickerController()
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
     
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
         
        init(parent: ImagePicker) {
            self.parent = parent
        }
         
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
         
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
     
    func makeUIViewController(context: Context) -> UIImagePickerController {
        controller.delegate = context.coordinator
        return controller
    }
     
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // You can add any additional configuration or updates here if needed.
    }
}
 
