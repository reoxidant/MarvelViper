//
//  CharacterTableViewCell.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 05.01.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    var viewModel: CellIdentifiable? {
        didSet {
            guard let viewModel = viewModel as? CharacterCellViewModel else { return }
            nameLabel.text = viewModel.characterName
            characterImageView.fetchImage(url: viewModel.characterThumbnailURL)
        }
    }

    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleToFill
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = 10
            characterImageView.backgroundColor = .systemBackground
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        characterImageView?.image = nil
    }
}
