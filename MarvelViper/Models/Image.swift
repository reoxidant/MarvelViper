//
//  Image.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

struct Image: Decodable {
    let path: String?
    let imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imageExtension = "extension"
    }
    
    var url: String {
        if let path = path, let imageExt = imageExtension {
            return path + "." + imageExt
        }
        
        return ""
    }
}
