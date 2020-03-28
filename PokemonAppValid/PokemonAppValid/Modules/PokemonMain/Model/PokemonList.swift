//
//  PokemonList.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct PokemonList: Mappable {
    var name: String? 
    var url : String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url  <- map["url"]
    }
}
