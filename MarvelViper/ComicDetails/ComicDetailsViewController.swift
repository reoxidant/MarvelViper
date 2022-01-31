//
//  ComicDetailsViewController.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 09.01.2022.
//

import UIKit

protocol ComicDetailsViewInputProtocol: AnyObject {
    func setupDescriptionLabel(_ text: String)
    func reloadData(for section: CharacterSectionViewModel)
    func stopActivityIndicator()
}

protocol ComicDetailsViewOutputProtocol {
    init(view: ComicDetailsViewInputProtocol)
    func viewDidLoad()
    func didTapCharacterCell(at indexPath: IndexPath)
}

class ComicDetailsViewController: UIViewController {

    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ComicDetailsViewOutputProtocol!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var characterSection = CharacterSectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        setupActivityIndicator()
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterDetailsVC = segue.destination as? CharacterDetailsViewController, let characterSummary = sender as? CharacterSummary {
            let configurator = CharacterDetailsConfigurator()
            configurator.configure(view: characterDetailsVC, character: nil, characterSummary: characterSummary)
        }
    }
}

extension ComicDetailsViewController {
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
}

extension ComicDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterSection.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = characterSection.rows[indexPath.row] as? CharacterSummaryCellViewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifiable, for: indexPath)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white.withAlphaComponent(0.5)
        cell.selectedBackgroundView = backgroundView
        
        cell.textLabel?.text = viewModel.characterName
        
        return cell
    }
}

extension ComicDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCharacterCell(at: indexPath)
    }
}

extension ComicDetailsViewController: ComicDetailsViewInputProtocol {
    func setupDescriptionLabel(_ text: String) {
        comicDescriptionLabel.text = text
    }
    
    func reloadData(for section: CharacterSectionViewModel) {
        characterSection = section
        tableView.reloadData()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
