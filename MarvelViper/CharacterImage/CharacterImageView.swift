//
//  CharacterImageView.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

import UIKit

protocol CharacterImageViewInputProtocol: AnyObject {
    func fetchImage(url: String?)
    func setupImage(from data: Data)
}

protocol CharacterImageViewOutputProtocol {
    init(view: CharacterImageViewInputProtocol)
    func provideImage(with url: URL)
}

class CharacterImageView: UIImageView {
    
    var presenter: CharacterImageViewOutputProtocol!
    private let configurator = CharacterImageConfigurator()

    func fetchImage(url: String?) {
        
        configurator.configure(view: self)
        
        guard let url = url, let imageUrl = URL(string: url) else {
            image = UIImage(named: "picture")
            return
        }
        
        presenter.provideImage(with: imageUrl)
    }
}

extension CharacterImageView: CharacterImageViewInputProtocol {
    func setupImage(from data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.image = UIImage(data: data)
            if let indicator = self?.subviews.first as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
        }
    }
}
