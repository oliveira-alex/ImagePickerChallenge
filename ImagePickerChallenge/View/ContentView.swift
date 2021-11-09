//
//  ContentView.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 30/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var images: [NamedImage] = []
    
    @State private var showingImagePicker = false
    @State private var newImage: UIImage?
    @State private var newImageName = ""
    
    @State private var showingEnterNameSheet = false


    var body: some View {
        NavigationView {
            List {
                ForEach(images.sorted(), id: \.id) { image in
                    NavigationLink(destination: DetailView(namedImage: image)) {
                        HStack {
                            Image(uiImage: image.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 45)
                            Text(image.name)
                        }
                    }
                }
                .onDelete(perform: removeImages)
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: showEnterNameSheet) {
                ImagePickerView(newImage: $newImage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    let showPicker = { showingImagePicker = true }
                    Button(action: showPicker) {
                        Image(systemName: "plus")
                            // without the padding the button stops responding after first tap
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showingEnterNameSheet, onDismiss: addImage) {
                EnterNameView(newImage: $newImage, newImageName: $newImageName)
            }
            .onAppear(perform: loadImages)
            .navigationTitle("Image List")
        }
    }
    
    func showEnterNameSheet() {
        guard newImage != nil else { return }
        
        showingEnterNameSheet = true
    }
    
    func addImage() {
        if newImageName.isEmpty {
            newImageName = "Unnamed Image"
        }
        
        let newNamedImage = NamedImage(name: newImageName, image: newImage!)
        images.append(newNamedImage)
        saveImages()
        
        newImageName = ""
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImages() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedImages")
        
        do {
            let data = try JSONEncoder().encode(self.images)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            
        }
    }
    
    func loadImages() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedImages")
        
        do {
            let data = try Data(contentsOf: filename)
            images = try JSONDecoder().decode([NamedImage].self, from: data)
        } catch {
            
        }
    }
    
    func removeImages(at offsets: IndexSet) {
        images.remove(atOffsets: offsets)
        saveImages()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}