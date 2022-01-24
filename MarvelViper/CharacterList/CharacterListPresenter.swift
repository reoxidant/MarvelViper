//
//  CharacterListPresenter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

import Foundation

class CharacterListPresenter: CharacterListViewOutputProtocol {
   
    unowned var view: CharacterListViewInputProtocol!
    var interactor: CharacterListInteractorInputProtocol!
    var router: CharacterListRouterInputProtocol!

    required init(view: CharacterListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let url = MarvelAPI.shared.getCharactersURL()
        interactor.fetchCharactersData(from: url)
    }
    
    func setupCharacters(with page: Int) {
        view.startActivityIndicator()
        let url = MarvelAPI.shared.getCharactersURL(page: page, limit: 50)
        interactor.fetchCharactersData(from: url)
    }
    
    func filterCharacters(with searchText: String) {
        view.startActivityIndicator()
        interactor.filterCharactersData(with: searchText)
    }
    
    func defineNewCurrentPage(with tag: Int, currentPage: Int) {
        interactor.calculateNewPage(with: tag, and: currentPage)
    }
    
    func didTapSelectedCell(at indexPath: IndexPath) {
        interactor.getCharacter(at: indexPath)
    }
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {

    func charactersDidReceive(_ characters: [Character]) {
        let section = CharacterSectionViewModel()
        characters.forEach { section.rows.append(CharacterCellViewModel(character: $0))}
        view.reloadData(for: section, isFiltered: false)
        view.stopActivityIndicator()
    }
    
    func charactersDidFiltered(_ characters: [Character]) {
        let section = CharacterSectionViewModel()
        characters.forEach { section.rows.append(CharacterCellViewModel(character: $0))}
        view.reloadData(for: section, isFiltered: true)
        view.stopActivityIndicator()
    }
    
    func receiveNewPage(page: Int) {
        view?.setupNewPage(page: page)
    }
    
    func characterDidReceive(_ character: Character) {
        router.showCharacterDetailsVC(by: character)
    }
}
