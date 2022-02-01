//
//  ComicCellViewModel.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 08.01.2022.
//

import Darwin

protocol ComicCellViewModelProtocol {
    var comicName: String? { get }
    var comicResourceURI: String? { get }
    init(comic: ComicSummary)
}

class ComicCellViewModel: CellIdentifiable, ComicCellViewModelProtocol {
    
    var cellIdentifiable: String {
        "comicCell"
    }
    
    var comicName: String? {
        comic.name
    }
    
    var comicResourceURI: String? {
        comic.resourceURI
    }
    
    private let comic: ComicSummary
    
    required init(comic: ComicSummary) {
        self.comic = comic
    }
}
