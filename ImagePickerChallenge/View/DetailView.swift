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
        VStack(spacing: 20) {
            Image(uiImage: namedImage.image)
                .resizable()
                .scaledToFit()
                .padding()
            
            MapView(locationCoordinate: namedImage.locationCoordinate)
                .padding()

            Spacer()
            
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .navigationTitle(Text(namedImage.name))
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
