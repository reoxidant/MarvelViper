//
//  CharacterListConfigurator.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

protocol CharacterListConfiguratorInputProtocol: AnyObject {
    func configure(view: CharacterListTableViewController)
}

class CharacterListConfigurator: CharacterListConfiguratorInputProtocol {
    
    func configure(view: CharacterListTableViewController) {
        let presenter = CharacterListPresenter(view: view)
        let interactor = CharacterListInteractor(presenter: presenter)
        let router = CharacterListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
