//
//  ImagePicker.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 30/10/2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.newImage = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var newImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
//    typealias UIViewControllerType = UIImagePickerController
}

//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker()
//    }
//}
