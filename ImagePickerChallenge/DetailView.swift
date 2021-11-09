//
//  DetailView.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 08/11/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var namedImage: NamedImage

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Image(uiImage: namedImage.image)
                .resizable()
                .scaledToFit()
//                .frame(width: 320, height: 180)
            
            Text(namedImage.name)
                .padding()
                
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
