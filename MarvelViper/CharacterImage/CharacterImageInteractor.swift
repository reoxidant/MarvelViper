//
//  CharacterImageInteractor.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

import Foundation

protocol CharacterImageInteractorInputProtocol {
    init(presenter: CharacterImageInteractorOutputProtocol)
    func provideImage(with url: URL)
    func saveImageToCache(with data: Data, and response: URLResponse)
}

protocol CharacterImageInteractorOutputProtocol: AnyObject {
    func receiveImageData(_ data: CharacterImageData)
}

class CharacterImageInteractor: CharacterImageInteractorInputProtocol {
    
    unowned let presenter: CharacterImageInteractorOutputProtocol!
    
    required init(presenter: CharacterImageInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideImage(with url: URL) {
        
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            let imageData = CharacterImageData(imagaData: cachedResponse.data)
            presenter.receiveImageData(imageData)
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] data, response in
            let imageData = CharacterImageData(imagaData: data)
            self?.presenter.receiveImageData(imageData)
            self?.saveImageToCache(with: data, and: response)
        }
    }
    
    func saveImageToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
