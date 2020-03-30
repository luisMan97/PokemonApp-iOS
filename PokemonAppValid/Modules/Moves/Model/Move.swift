//
//  Move.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct Move: Mappable {
    var name: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name    <- map["name"]
    }
}
