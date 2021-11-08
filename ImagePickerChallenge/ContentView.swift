//
//  ContentView.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 30/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var pictureNames = ["Example"]
    @State private var showingPicker = false
    @State private var newImage: UIImage?
    
    @State private var images: [UIImage] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(images, id: \.self) { imageName in
                    // NavigationLink to DetailView
                    HStack {
                        Image(uiImage: imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 45)
                        Text("No name yet")
                    }
                }
            }
            .sheet(isPresented: $showingPicker, onDismiss: addImage) {
                ImagePicker(newImage: $newImage)
            }
            .toolbar {
                let showPicker = { showingPicker = true }
                Button(action: showPicker) {
                    Image(systemName: "plus")
                        // without the padding the button stops responding after first tap
                        .padding()
                }
            }
            .navigationTitle("Image List")
        }
    }
    
    func addImage() {
        guard let newImage = newImage else { return }
        
        images.append(newImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
