//
//  PokemonsViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 24/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class PokemonsViewModel {

    private var manager = PokemonsManager()
    
    // Internal Computed Properties
    
    var numberOfPokemons: Int {
        return pokemons.count
    }
    
    var pokemons: [Pokemon] {
        get {
            return manager.pokemons
        }
        set {
            manager.pokemons = newValue
        }
    }
    
    var originalPokemonsList: [Pokemon] {
        return manager.originalPokemonsList
    }
    
    func getPokemons(handler: CallServiceHandler) {
        manager.getPokemons(handler: handler)
    }
    
    func search(text: String?) {
        pokemons.removeAll()
        if text?.count != 0 {
            for pokemon in originalPokemonsList {
                guard let pokemonToSearch = text else { return }
                let range = pokemon.name?.lowercased().range(of: pokemonToSearch, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    pokemons.append(pokemon)
                }
            }
        } else {
            for pokemon in originalPokemonsList {
                pokemons.append(pokemon)
            }
        }
    }

}
