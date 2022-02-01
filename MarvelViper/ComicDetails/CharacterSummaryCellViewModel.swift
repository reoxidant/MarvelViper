//
//  CharacterSummaryCellViewModel.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

import Foundation

protocol CharacterSummaryCellViewModelProtocol {
    var characterName: String? { get }
    var characterResourceURL: String? { get }
    init(characterSummary: CharacterSummary)
}

class CharacterSummaryCellViewModel: CharacterSummaryCellViewModelProtocol, CellIdentifiable {
    
    var cellIdentifiable: String {
        "characterCell"
    }
    
    var characterName: String? {
        characterSummary.name
    }
    
    var characterResourceURL: String? {
        characterSummary.resourceURI
    }
    
    private let characterSummary: CharacterSummary
    
    required init(characterSummary: CharacterSummary) {
        self.characterSummary = characterSummary
    }
}
