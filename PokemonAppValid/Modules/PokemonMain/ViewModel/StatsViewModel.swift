
//
//  StatsViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class StatsViewModel {

    // Internal Properties
    var stats: [Stat]? 

    // Internal Computed Properties
    
    var numberOfStats: Int {
        return stats?.count ?? 0
    }

}
