//
//  CharacterDetailInteractor.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

protocol CharacterDetailInteractorInputProtocol {
    init(presenter: CharactersDetailInteractorOutputProtocol, character: Character?, characterSummary: CharacterSummary?)
    func fetchCharacter()
    func getComicList()
}

protocol CharactersDetailInteractorOutputProtocol: AnyObject {
    func receiveCharacter(data: CharacterDetailsData)
    func receiveComicList(_ list: ComicList?)
}

class CharacterDetailsInteractor: CharacterDetailInteractorInputProtocol {
    
    unowned let presenter: CharactersDetailInteractorOutputProtocol!
    private var character: Character?
    private var characterSummary: CharacterSummary?
    
    required init(presenter: CharactersDetailInteractorOutputProtocol, character: Character?, characterSummary: CharacterSummary?) {
        self.presenter = presenter
        self.character = character
        self.characterSummary = characterSummary
    }
    
    func fetchCharacter() {
        if let character = character {
            buildDetailsData(by: character)
            return
        }
        
        if let characterSummary = characterSummary {
            let characterURI = characterSummary.resourceURI ?? ""
            let url = MarvelAPI.shared.getFullURLBy(resourceURI: characterURI)
            
            NetworkManager.shared.fetchCharacter(from: url) { [weak self] result in
                switch result {
                case .success(let character):
                    guard let character = character else { return }
                    self?.buildDetailsData(by: character)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getComicList() {
        guard let character = character else { return }
        presenter.receiveComicList(character.comics)
    }
    
    private func buildDetailsData(by character: Character) {
        guard let name = character.name, let url = character.thumbnail?.url, let description = character.description else { return }
        let detailsData = CharacterDetailsData(name: name, thumbnailURL: url, description: description)
        presenter.receiveCharacter(data: detailsData)
    }
}
