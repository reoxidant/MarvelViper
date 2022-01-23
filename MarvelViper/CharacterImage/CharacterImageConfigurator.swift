//
//  CharacterImageConfigurator.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

protocol CharacterImageConfiguratorInputProtocol {
    func configure(view: CharacterImageView)
}

class CharacterImageConfigurator: CharacterImageConfiguratorInputProtocol {
    func configure(view: CharacterImageView) {
        let presenter = CharacterImagePresenter(view: view)
        let interactor = CharacterImageInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
