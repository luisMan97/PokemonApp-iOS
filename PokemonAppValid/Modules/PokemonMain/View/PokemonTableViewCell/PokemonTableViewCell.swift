//
//  PokemonTableViewCell.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 28/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    //var tapViewPostsAction : ((UITableViewCell) -> ())?
    
    // Observers Internal Properties
    var viewModel: PokemonCellViewModel! {
        didSet {
            setup()
        }
    }
    
    // MARK: Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        pokemonNameLabel.text = viewModel?.name
        pokemonIDLabel.text = viewModel?.pokemonId
        if let data = viewModel.pokemon?.image {
            pokemonImage.image = UIImage(data: data)
        }
    }
    
}
