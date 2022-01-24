//
//  CharacterCellViewModel.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

protocol CellIdentifiable {
    var cellIdentifiable: String { get }
}

protocol CharacterCellViewModelProtocol {
    var characterName: String? { get }
    var characterThumbnailURL: String? { get }
    init(character: Character)
}

class CharacterCellViewModel: CharacterCellViewModelProtocol, CellIdentifiable {
    
    var cellIdentifiable: String {
        "characterCell"
    }
    
    var characterName: String? {
        character.name
    }
    
    var characterThumbnailURL: String? {
        character.thumbnail?.url
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}

class CharacterSectionViewModel {
    var rows: [CellIdentifiable] = []
}
