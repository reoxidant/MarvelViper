//
//  DataManager.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 06.01.2022.
//

import Foundation

class DataManager {

    static let shared = DataManager()
    
    private let userDefault = UserDefaults.standard
    
    private var characters = [Character]()
    private var comicCharacters = [CharacterSummary]()
    
    private init() {}
    
    func setCharacters(_ characters: [Character]) {
        self.characters = characters
    }
    
    func setComicCharacters(_ comicCharacters: [CharacterSummary]) {
        self.comicCharacters = comicCharacters
    }
    
    func getCharacters() -> [Character] {
        characters
    }
    
    func getCharacter(at indexPath: IndexPath) -> Character {
        characters[indexPath.row]
    }
    
    func getComicCharacter(at indexPath: IndexPath) -> CharacterSummary {
        comicCharacters[indexPath.row]
    }
}
