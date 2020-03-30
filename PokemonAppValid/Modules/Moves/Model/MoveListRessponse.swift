//
//  MoveListRessponse.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct MoveListRessponse: Mappable {
    var count: Int?
    var result: [MoveList]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        count  <- map["count"]
        result <- map["results"]
    }
}
