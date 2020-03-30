//
//  Pokemon.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

struct Pokemon: Mappable {
    var name: String? 
    var id: Int?
    var sprite: Sprite?
    var moves: [MoveOfPokemon]?
    var species: Species?
    var stats: [Stat]?
    var types: [Type]?
    var image: Data?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name    <- map["name"]
        id      <- map["id"]
        sprite  <- map["sprites"]
        moves   <- map["moves"]
        species <- map["species"]
        stats   <- map["stats"]
        types   <- map["types"]
        image   <- map["image"]
    }
}

struct MoveOfPokemon: Mappable {
    var move: MoveDetail?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        move <- map["move"]
    }
}

struct Type: Mappable {
    var type: TypeDetail?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        type <- map["type"]
    }
}

struct TypeDetail: Mappable {
    var name: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}

struct Stat: Mappable {
    var baseStat: Int?
    var stat: StatDetail?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        baseStat <- map["base_stat"]
        stat     <- map["stat"]
    }
}

struct StatDetail: Mappable {
    var name: String?
    var url: String?  
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url  <- map["url"]
    }
}

struct MoveDetail: Mappable {
    var name: String?
    var url: String?  
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url  <- map["url"]
    }
}

struct Species: Mappable {
    var name: String?
    var url: String?  
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url  <- map["url"]
    }
}

/////

struct PokemonSpecies: Mappable {
    var evolutionChain: EvolutionChain?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        evolutionChain <- map["evolution_chain"]
    }
}

struct EvolutionChain: Mappable {
    var url: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        url <- map["url"]
    }
}

// 

struct EvolutionChainDetail: Mappable {
    var chain: Chain?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        chain <- map["chain"]
    }
}

struct Chain: Mappable {
    var species: Species?
    var envolvesTo: [EnvolvesTo]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        species <- map["species"]
        envolvesTo <- map["evolves_to"]
    }
}

struct EvolutionsDetails: Mappable {
    var minHappines: Int?
    var minLevel: Int?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        minHappines <- map["min_happiness"]
        minLevel <- map["min_level"]
    }
}

struct EnvolvesTo: Mappable {
    var species: Species?
    var envolvesTo: [EnvolvesTo]?
    var evolutionsDetails: [EvolutionsDetails]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        species <- map["species"]
        envolvesTo <- map["evolves_to"]
        evolutionsDetails <- map["evolution_details"]
    }
}
