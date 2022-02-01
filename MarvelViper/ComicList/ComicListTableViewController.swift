//
//  ComicListTableViewController.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 08.01.2022.
//

import UIKit

class ComicListTableViewController: UITableViewController {

    var comics: ComicList?
    
    var viewModel: ComicListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1)
        
        setupNavigationBar()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let comicDetailsVC = segue.destination as? ComicDetailsViewController, let comic = sender as? ComicSummary {
            let configurator = ComicDetailsConfigurator()
            configurator.configure(view: comicDetailsVC, comic: comic)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comicsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellViewModel = viewModel.getCellViewModel(at: indexPath) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifiable, for: indexPath)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white.withAlphaComponent(0.5)
        cell.selectedBackgroundView = backgroundView
        
        cell.textLabel?.text = cellViewModel.comicName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let comic = viewModel.getComic(at: indexPath)
        performSegue(withIdentifier: "showComicDetails", sender: comic)
    }
}

extension ComicListTableViewController {
    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 0.7)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = .white
    }
}
