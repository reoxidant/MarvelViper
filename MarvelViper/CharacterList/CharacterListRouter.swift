//
//  CharacterListRouter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

protocol CharacterListRouterInputProtocol {
    init(view: CharacterListTableViewController)
    func showCharacterDetailsVC(by character: Character)
}

class CharacterListRouter: CharacterListRouterInputProtocol {
    
    unowned let view: CharacterListTableViewController
    
    required init(view: CharacterListTableViewController) {
        self.view = view
    }
    
    func showCharacterDetailsVC(by character: Character) {
        view.performSegue(withIdentifier: "showDetails", sender: character)
    }
}
