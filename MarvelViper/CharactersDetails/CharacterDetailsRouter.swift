//
//  CharacterDetailsRouter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 08.01.2022.
//


protocol CharacterDetailsRouterInputProtocol {
    init(view: CharacterDetailsViewController)
    func showComicList(by list: ComicList?)
}

class CharacterDetailsRouter: CharacterDetailsRouterInputProtocol {
    
    unowned let view: CharacterDetailsViewController
    
    required init(view: CharacterDetailsViewController) {
        self.view = view
    }
    
    func showComicList(by list: ComicList?) {
        view.performSegue(withIdentifier: "showComicList", sender: list)
    }
}
