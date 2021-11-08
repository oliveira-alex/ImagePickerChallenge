//
//  NamedImageStruct.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 08/11/21.
//

import SwiftUI

struct NamedImage: Comparable {
    var id = UUID()
    var name: String
    var image: UIImage
        
    static func < (lhs: NamedImage, rhs: NamedImage) -> Bool {
        lhs.name < rhs.name
    }
}

extension NamedImage: Codable {
    enum CodingKeys: CodingKey {
        case name, imageData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        let imageData = try container.decode(Data.self, forKey: .imageData)
        image = UIImage(data: imageData)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        let imageData = image.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .imageData)
    }
}
