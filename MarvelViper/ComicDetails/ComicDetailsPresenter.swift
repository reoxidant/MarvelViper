//
//  ComicDetailsPresenter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

import Foundation

struct ComicDetailsData {
    let title: String
    let fullDescription: String
    let characters: [CharacterSummary]
}

class ComicDetailsPresenter: ComicDetailsViewOutputProtocol {
    
    unowned let view: ComicDetailsViewInputProtocol
    var router: ComicDetailsRouterInputProtocol!
    var interactor: ComicDetailsInteractorInputProtocol!
    
    required init(view: ComicDetailsViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchComic()
    }
    
    func didTapCharacterCell(at indexPath: IndexPath) {
        interactor.getComicCharacter(at: indexPath)
    }
}

extension ComicDetailsPresenter: ComicDetailsInteractorOutputProtocol {
    
    func comicDataDidReceive(_ comic: ComicDetailsData) {
        let section = CharacterSectionViewModel()
        let characters = comic.characters
        
        characters.forEach { section.rows.append(CharacterSummaryCellViewModel(characterSummary: $0)) }
        
        view.setupDescriptionLabel(comic.fullDescription)
        view.reloadData(for: section)
        view.stopActivityIndicator()
    }
    
    func characterSummaryDidReceive(_ character: CharacterSummary) {
        router.showCharacterDetailsVC(by: character)
    }
}
