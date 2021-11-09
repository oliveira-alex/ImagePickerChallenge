//
//  EnterNameView.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 08/11/21.
//

import SwiftUI

struct EnterNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var newImage: UIImage?
    @Binding var newImageName: String

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            if newImage != nil {
                Image(uiImage: newImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 180)
            }
            
            TextField("New Image Name", text: $newImageName)
                .multilineTextAlignment(.center)
                .padding()
                
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//struct EnterNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterNameView()
//    }
//}
