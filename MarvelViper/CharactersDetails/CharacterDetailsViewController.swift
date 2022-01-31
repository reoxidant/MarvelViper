//
//  CharacterDetailsViewController.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

import UIKit

protocol CharacterDetailsViewControllerInputProtocol: AnyObject {
    func fetchCharacter()
    func setTitle(_ title: String)
    func setupCharacterImage(_ url: String)
    func setupDescriptionLabel(_ text: String)
}

protocol CharacterDetailsViewControllerOutputProtocol {
    init(view: CharacterDetailsViewControllerInputProtocol)
    func provideCharacter()
    func didTapComicsButton()
}

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleToFill
            characterImageView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: CharacterDetailsViewControllerOutputProtocol!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.color = .white
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        setupNavigationBar()
        presenter.provideCharacter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
           let comicListTableVC = navController.topViewController as? ComicListTableViewController,
           let sender = sender as? ComicList {
            comicListTableVC.viewModel = ComicListViewModel(comics: sender)
        }
    }
    
    @IBAction func didTapComicsButton(_ sender: UIBarButtonItem) {
        presenter.didTapComicsButton()
    }
}


extension CharacterDetailsViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center.y = characterImageView.center.y
        activityIndicator.center.x = characterImageView.frame.width / 2
        
        characterImageView.addSubview(activityIndicator)
    }
}


extension CharacterDetailsViewController: CharacterDetailsViewControllerInputProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupCharacterImage(_ url: String) {
        characterImageView.fetchImage(url: url)
    }
    
    func setupDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
    }
    
    func fetchCharacter() {
        presenter.provideCharacter()
    }
}
