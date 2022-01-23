//
//  CharacterImagePresenter.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

import Foundation

struct CharacterImageData {
    let imagaData: Data
}

class CharacterImagePresenter: CharacterImageViewOutputProtocol {
    
    unowned let view: CharacterImageViewInputProtocol!
    var interactor: CharacterImageInteractorInputProtocol!
    
    required init(view: CharacterImageViewInputProtocol) {
        self.view = view
    }
    
    func provideImage(with url: URL) {
        interactor.provideImage(with: url)
    }
}

extension CharacterImagePresenter: CharacterImageInteractorOutputProtocol {
    func receiveImageData(_ data: CharacterImageData) {
        view.setupImage(from: data.imagaData)
    }
}
