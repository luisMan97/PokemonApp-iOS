
//
//  MovesViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class MovesViewModel {

    // Internal Properties
    var moves: [Move]? 

    // Internal Computed Properties
    
    var numberOfMoves: Int {
        return moves?.count ?? 0
    }

}
