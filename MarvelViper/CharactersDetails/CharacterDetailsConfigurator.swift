//
//  CharacterDetailsConfigurator.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

protocol CharacterDetailsConfiguratorInputProtocol {
    func configure(view: CharacterDetailsViewController, character: Character?, characterSummary: CharacterSummary?)
}

class CharacterDetailsConfigurator: CharacterDetailsConfiguratorInputProtocol {

    func configure(view: CharacterDetailsViewController, character: Character?, characterSummary: CharacterSummary?) {
        let presenter = CharacterDetailsPresenter(view: view)
        let interactor = CharacterDetailsInteractor(presenter: presenter, character: character, characterSummary: characterSummary)
        let router = CharacterDetailsRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
