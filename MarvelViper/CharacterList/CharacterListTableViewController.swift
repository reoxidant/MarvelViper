//
//  CharacterListTableViewController.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

import UIKit

protocol CharacterListViewInputProtocol: AnyObject {
    func setupNewPage(page: Int)
    func reloadData(for section: CharacterSectionViewModel, isFiltered: Bool)
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol CharacterListViewOutputProtocol {
    init(view: CharacterListViewInputProtocol)
    func viewDidLoad()
    func setupCharacters(with page: Int)
    func filterCharacters(with searchText: String)
    func defineNewCurrentPage(with tag: Int, currentPage: Int)
    func didTapSelectedCell(at indexPath: IndexPath)
}

class CharacterListTableViewController: UITableViewController {
    
    var presenter: CharacterListViewOutputProtocol!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let configurator: CharacterListConfiguratorInputProtocol = CharacterListConfigurator()
    private var charactersSection = CharacterSectionViewModel()
    private var filteredSection = CharacterSectionViewModel()
    
    private var currentPage: Int = 0 {
        didSet {
            presenter.setupCharacters(with: currentPage)
        }
    }
    
    private lazy var searchController: UISearchController =  {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        return searchController
    }()
    
    private var searchBarIsActive: Bool {
        
        let textIsEmpty = searchController.searchBar.text?.isEmpty ?? false
        
        if searchController.isActive && !textIsEmpty {
            return true
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(view: self)
        
        tableView.rowHeight = 125
        
        setupActivityIndicator()
        setupNavigationBar()
        setupSearchController()
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterDetailsVC = segue.destination as? CharacterDetailsViewController, let character = sender as? Character {
            let configurator = CharacterDetailsConfigurator()
            configurator.configure(view: characterDetailsVC, character: character, characterSummary: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarIsActive ? filteredSection.rows.count : charactersSection.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = searchBarIsActive ? filteredSection.rows[indexPath.row] : charactersSection.rows[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifiable, for: indexPath) as? CharacterTableViewCell {

            let redBackgroundView = UIView()
            redBackgroundView.backgroundColor = UIColor(red: 230 / 255, green: 36 / 255, blue: 41 / 255, alpha: 1)
            cell.selectedBackgroundView = redBackgroundView
              
            cell.viewModel = viewModel

            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapSelectedCell(at: indexPath)
    }
    
    @IBAction func managePageData(_ sender: UIBarButtonItem) {
        presenter.defineNewCurrentPage(with: sender.tag, currentPage: currentPage)
    }
}

extension CharacterListTableViewController {
    private func setupNavigationBar() {
        title = "Marvel Characters"
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1)
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
}

extension CharacterListTableViewController: CharacterListViewInputProtocol {
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func reloadData(for section: CharacterSectionViewModel, isFiltered: Bool) {
        if isFiltered {
            self.filteredSection = section
        } else {
            self.charactersSection = section
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func setupNewPage(page: Int) {
        currentPage = page
    }
}

extension CharacterListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.filterCharacters(with: searchText)
    }
}
