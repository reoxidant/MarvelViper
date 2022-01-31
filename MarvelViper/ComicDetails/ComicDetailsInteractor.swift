//
//  ComicDetailsInteractor.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

import Foundation

protocol ComicDetailsInteractorInputProtocol {
    init(presenter: ComicDetailsInteractorOutputProtocol, comic: ComicSummary)
    func fetchComic()
    func getComicCharacter(at indexPath: IndexPath)
}

protocol ComicDetailsInteractorOutputProtocol: AnyObject {
    func comicDataDidReceive(_ comic: ComicDetailsData)
    func characterSummaryDidReceive(_ character: CharacterSummary)
}

class ComicDetailsInteractor: ComicDetailsInteractorInputProtocol {
    
    unowned let presenter: ComicDetailsInteractorOutputProtocol
    private let comic: ComicSummary
    
    required init(presenter: ComicDetailsInteractorOutputProtocol, comic: ComicSummary) {
        self.presenter = presenter
        self.comic = comic
    }
    
    func fetchComic() {
        let resourceURI = comic.resourceURI ?? ""
        let url = MarvelAPI.shared.getFullURLBy(resourceURI: resourceURI)
        
        NetworkManager.shared.fetchComic(from: url) { [weak self] result in
            switch result {
            case .success(let comic):
                guard let comic = comic, let title = comic.title, let characters = comic.characters?.items else { return }
                
                let fullDescription = comic.fullDescription
                let comicDetailsData = ComicDetailsData(title: title, fullDescription: fullDescription, characters: characters)
                
                self?.presenter.comicDataDidReceive(comicDetailsData)
                DataManager.shared.setComicCharacters(characters)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getComicCharacter(at indexPath: IndexPath) {
        let characterSummary = DataManager.shared.getComicCharacter(at: indexPath)
        presenter.characterSummaryDidReceive(characterSummary)
    }
}
