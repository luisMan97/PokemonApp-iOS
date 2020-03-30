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
    @IBOutlet weak var pokemonImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageWidhtConstraint: NSLayoutConstraint!
    
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
        DispatchQueue.main.async {
            self.pokemonImageHeightConstraint.constant = self.bounds.height - 21.5
            self.pokemonImageWidhtConstraint.constant = self.pokemonImageHeightConstraint.constant
        }
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
