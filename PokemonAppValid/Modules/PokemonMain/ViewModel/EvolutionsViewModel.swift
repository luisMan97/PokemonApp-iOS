//
//  PokemonViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class EvolutionsViewModel {

    // Internal Properties
    var id: Int?
    
    var evolutionChainDetail: EvolutionChainDetail? {
        return manager.evolutionChainDetail
    }
    
    private var manager = EvolutionsManager()

    func getPokemonSpecies(handler: CallServiceHandler) {
        manager.getPokemonSpecies(id: id, handler: handler)
    }

}
