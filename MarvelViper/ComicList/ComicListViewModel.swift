//
//  ComicListViewModel.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 08.01.2022.
//

import Foundation

protocol ComicListViewModelProtocol {
    var comicsCount: Int { get }
    init(comics: ComicList)
    func getCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel?
    func getComic(at indexPath: IndexPath) -> ComicSummary?
}

class ComicListViewModel: ComicListViewModelProtocol {
    
    var comicsCount: Int {
        self.comics.items?.count ?? 0
    }
    
    private let comics: ComicList
    
    required init(comics: ComicList) {
        self.comics = comics
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel? {
        guard let comic = comics.items?[indexPath.row] else { return nil }
        return ComicCellViewModel(comic: comic)
    }
    
    func getComic(at indexPath: IndexPath) -> ComicSummary? {
        guard let comic = comics.items?[indexPath.row] else { return nil }
        return comic
    }
}
