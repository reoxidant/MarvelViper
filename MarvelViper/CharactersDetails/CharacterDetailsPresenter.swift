//
//  CharacterDetailsPresenter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

struct CharacterDetailsData {
    let name: String
    let thumbnailURL: String
    let description: String
}

class CharacterDetailsPresenter: CharacterDetailsViewControllerOutputProtocol {
    
    unowned let view: CharacterDetailsViewControllerInputProtocol!
    var interactor: CharacterDetailInteractorInputProtocol!
    var router: CharacterDetailsRouterInputProtocol!
    
    required init(view: CharacterDetailsViewControllerInputProtocol) {
        self.view = view
    }
    
    func provideCharacter() {
        interactor.fetchCharacter()
    }
    
    func didTapComicsButton() {
        interactor.getComicList()
    }
}

extension CharacterDetailsPresenter: CharactersDetailInteractorOutputProtocol {
    
    func receiveCharacter(data: CharacterDetailsData) {
        
        let description = data.description.isEmpty ? "Not found description" : data.description
        
        view.setTitle(data.name)
        view.setupDescriptionLabel(description)
        view.setupCharacterImage(data.thumbnailURL)
    }
    
    func receiveComicList(_ list: ComicList?) {
        router.showComicList(by: list)
    }
}
