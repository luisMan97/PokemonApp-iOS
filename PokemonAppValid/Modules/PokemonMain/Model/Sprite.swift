//
//  Sprite.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct Sprite: Mappable {
    var frontDefault: String?
    var defaultSprite: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        frontDefault <- map["front_default"]
        defaultSprite <- map["default"]
    }
}
