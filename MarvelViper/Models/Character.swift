//
//  Character.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: Image?
    let resourceURI: String?
    let comics: ComicList?
    
    init(name: String, description: String, thumbnail: Image, resourceURI: String, comics: ComicList) {
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
    }
}

struct CharacterDataWrapper: Decodable {
    let data: CharacterDataContainer?
}

struct CharacterDataContainer: Decodable {
    let results: [Character]?
}

struct CharacterList: Decodable {
    let items: [CharacterSummary]?
}

struct CharacterSummary: Decodable {
    let resourceURI: String?
    let name: String?
    let role: String?
}
