//
//  Router.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import Alamofire

enum ApiManagerConstants {
    enum keys {
        static let endpoint = "https://pokeapi.co/api/v2/"
    }
}

enum Router: URLRequestConvertible {
    
    case Pokemons
    case Pokemon([String: AnyObject])
    case PokemonSpecies([String: AnyObject])
    case Ability([String: AnyObject])
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Pokemons, 
             .Pokemon,
             .PokemonSpecies,
             .Ability:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Pokemons:
            return "pokemon?limit=151"
        case .Pokemon(let parameters):
            let name = parameters["name"] as? String ?? ""
            return "pokemon/\(name)"
        case .PokemonSpecies(let parameters):
            let id = parameters["id"] as? Int ?? 0
            return "pokemon-species/\(id)"
        case .Ability(let parameters):
            let id = parameters["id"] as? Int ?? 0
            return "ability/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = URL(string: ApiManagerConstants.keys.endpoint) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue
        
        print("URL Service: ", mutableURLRequest)
        
        switch self {
        case .Pokemons:
            guard let url = NSURL(string: ApiManagerConstants.keys.endpoint + path) else {
                return URLRequest(url: URL(fileURLWithPath: ""))
            }
            var mutableURLRequest = URLRequest(url: url as URL)
            mutableURLRequest.httpMethod = method.rawValue
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest as URLRequestConvertible, with: nil)
        case .Pokemon:
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest as URLRequestConvertible, with: nil)
        case .PokemonSpecies:
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest as URLRequestConvertible, with: nil)
        case .Ability:
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest as URLRequestConvertible, with: nil)
        }
    }
    
}
