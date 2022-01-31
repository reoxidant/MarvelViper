//
//  ComicDetailsRouter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

protocol ComicDetailsRouterInputProtocol {
    init(view: ComicDetailsViewController)
    func showCharacterDetailsVC(by character: CharacterSummary)
}

class ComicDetailsRouter: ComicDetailsRouterInputProtocol {
    
    unowned let view: ComicDetailsViewController
    
    required init(view: ComicDetailsViewController) {
        self.view = view
    }
    
    func showCharacterDetailsVC(by character: CharacterSummary) {
        view.performSegue(withIdentifier: "showDetails", sender: character)
    }
}
