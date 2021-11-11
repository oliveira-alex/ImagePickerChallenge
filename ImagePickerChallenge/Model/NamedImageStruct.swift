//
//  NamedImageStruct.swift
//  ImagePickerChallenge
//
//  Created by Alex Oliveira on 08/11/21.
//

import CoreLocation
import SwiftUI

struct NamedImage: Comparable {
    var id = UUID()
    var name: String
    var image: UIImage
    var locationCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
    static func < (lhs: NamedImage, rhs: NamedImage) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: NamedImage, rhs: NamedImage) -> Bool {
        if lhs.name == rhs.name && lhs.image == rhs.image {
            return true
        }
        
        return false
    }
}

extension NamedImage: Codable {
    enum CodingKeys: CodingKey {
        case name, imageData, latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        let imageData = try container.decode(Data.self, forKey: .imageData)
        image = UIImage(data: imageData)!
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        let imageData = image.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .imageData)
        
        try container.encode(Double(locationCoordinate.latitude), forKey: .latitude)
        try container.encode(Double(locationCoordinate.longitude), forKey: .longitude)
        
    }
}
