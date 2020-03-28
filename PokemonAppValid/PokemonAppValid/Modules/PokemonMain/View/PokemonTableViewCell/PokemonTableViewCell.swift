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
    var pokemon: Pokemon? {
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
        pokemonNameLabel.text = pokemon?.name
        pokemonIDLabel.text = "\(pokemon?.id ?? 0)"
        
        if let frontDefault = pokemon?.sprite?.frontDefault {
            pokemonImage.downloaded(from: frontDefault, onComplete: nil)
        } else if let id = pokemon?.id {
            pokemonImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(id).png", onComplete: nil)
        }
    }
    
}
