//
//  CharacterListInteractor.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

import Foundation

protocol CharacterListInteractorInputProtocol {
    init(presenter: CharacterListInteractorOutputProtocol)
    func fetchCharactersData(from url: String)
    func filterCharactersData(with searchText: String)
    func calculateNewPage(with tag: Int, and page: Int)
    func getCharacter(at indexPath: IndexPath)
}

protocol CharacterListInteractorOutputProtocol: AnyObject {
    func receiveNewPage(page: Int)
    func charactersDidReceive(_ characters: [Character])
    func charactersDidFiltered(_ characters: [Character])
    func characterDidReceive(_ character: Character)
}

class CharacterListInteractor: CharacterListInteractorInputProtocol {
    
    unowned var presenter: CharacterListInteractorOutputProtocol!
    
    required init(presenter: CharacterListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCharactersData(from url: String) {
        NetworkManager.shared.fetchCharacters(from: url) { result in
            switch result {
                case .success(let characters):
                    self.presenter.charactersDidReceive(characters)
                    DataManager.shared.setCharacters(characters)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func filterCharactersData(with searchText: String) {
        let characters = DataManager.shared.getCharacters()
        let filteredCharacters = characters.filter({ $0.name?.lowercased().contains(searchText.lowercased()) ?? false })
        presenter.charactersDidFiltered(filteredCharacters)
    }
    
    func calculateNewPage(with tag: Int, and page: Int) {
        
        var newPage = page
        
        switch tag {
            case 0:
                newPage = newPage == 0 ? newPage : newPage - 1
            case 1:
                newPage += 1
            default:
                break
        }
        
        presenter.receiveNewPage(page: newPage)
    }
    
    func getCharacter(at indexPath: IndexPath) {
        let character = DataManager.shared.getCharacter(at: indexPath)
        presenter.characterDidReceive(character)
    }
}
