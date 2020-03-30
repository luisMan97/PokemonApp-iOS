//
//  PokemonViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class PokemonViewModel {

    // Internal Properties
    var pokemon: Pokemon?
    
    var ability: Ability? {
        return manager.ability
    }
    
    private let manager = PokemonManager()
    
    func getAbilities(handler: CallServiceHandler) {
        manager.getAbilities(pokemon: pokemon, handler: handler)
    }

}
