//
//  PokemonViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import Foundation

class PokemonCellViewModel {
    
    var pokemon: Pokemon?
    
    init(pokemon: Pokemon?) {
        self.pokemon = pokemon
    }
    
    var name: String {
        return pokemon?.name ?? ""
    }
    
    var pokemonId: String {
        if let id = pokemon?.id {
            var idString = ""
            if id < 10 {
                idString = "#00\(id)"
            } else if id > 99 {
                idString = "#\(id)"
            } else {
                idString = "#0\(id)"
            }
            return idString
        } else {
            return "#000"
        }
    }

}
