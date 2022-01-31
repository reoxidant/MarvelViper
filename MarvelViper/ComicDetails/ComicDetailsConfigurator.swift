//
//  ComicDetailsConfigurator.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

protocol ComicDetailsConfiguratorInputProtocol {
    func configure(view: ComicDetailsViewController, comic: ComicSummary)
}

class ComicDetailsConfigurator: ComicDetailsConfiguratorInputProtocol {
    func configure(view: ComicDetailsViewController, comic: ComicSummary) {
        let presenter = ComicDetailsPresenter(view: view)
        let interactor = ComicDetailsInteractor(presenter: presenter, comic: comic)
        let router = ComicDetailsRouter(view: view)
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
    }
}
