//
//  Ability.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 28/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct Ability: Mappable {
    var effectEntries: [EffectEntries]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        effectEntries <- map["effect_entries"]
    }
}

struct EffectEntries: Mappable {
    var effect: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        effect <- map["effect"]
    }
}
