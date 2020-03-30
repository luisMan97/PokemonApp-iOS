//
//  PokemonsManager.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class PokemonsManager {
    
    // Private Properties
    var originalPokemonsList: [Pokemon] = []
    var pokemons: [Pokemon] = []
    // Private Properties
    private var listOfNames = [""]
    // ApiManager
    private let apiManager = ApiManager()
    
    // MARK: - Internal Methods
    
    func getPokemons(handler: CallServiceHandler) {
        apiManager.callServiceObject(service: .Pokemons) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let pokemonReponse = PokeApiResponse(JSON: jsonResult) {
                    
                    //print("getPokemons JSON\n", jsonResult)
                    strongSelf.getDataForEachPokemon(pokemonReponse: pokemonReponse, handler: handler)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getDataForEachPokemon(pokemonReponse: PokeApiResponse, handler: CallServiceHandler) {
        var listOfNames = getListOfNames(pokemonReponse)
        listOfNames.removeLast()
        let originalListOfNames = getListOfNames(pokemonReponse)
        
        pokemons.removeAll()
        
        listOfNames.forEach {
            let parameters = ["name": $0] as [String: AnyObject]
            apiManager.callServiceObject(service: .Pokemon(parameters)) { [weak self] (result, error) in
                guard let strongSelf = self else {
                    handler?(nil, nil)
                    return
                }
                if let error = error {
                    handler?(false, error)
                } else if let result = result {
                    if let jsonResult = result as? [String: AnyObject],
                        let id = jsonResult["id"] as? Int {
                        strongSelf.getImage(id: id, jsonResult: jsonResult, handler: handler)
                    } else {
                        handler?(nil, nil)
                    }
                } else {
                    handler?(nil, nil)
                }
            }
        }
        
        let parameters = ["name": originalListOfNames.last] as [String: AnyObject]
        
        apiManager.callServiceObject(service: .Pokemon(parameters)) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let id = jsonResult["id"] as? Int {
                    strongSelf.getImage(id: id, jsonResult: jsonResult, handler: handler)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getImage(id: Int, jsonResult: [String: AnyObject], handler: CallServiceHandler) {
        getImage(id: id) { [weak self] (data, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let data = data {
                var jsonPokemon = jsonResult
                jsonPokemon["image"] = data as AnyObject
                guard let pokemon = Pokemon(JSON: jsonPokemon) else { return }
                strongSelf.pokemons.append(pokemon)
                strongSelf.originalPokemonsList.append(pokemon)
                handler?(true, nil)
            } else {
                handler?(nil, nil)
            }
            
        }
    }
    
    private func getImage(id: Int, handler: CallServiceHandlerWithData) {
        apiManager.callImage(url: "https://pokeres.bastionbot.org/images/pokemon/\(id).png") { (data, error) in
            if let error = error {
                handler?(nil, error)
            } else if let data = data {
                handler?(data, nil)
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getListOfNames(_ pokeApiResponse: PokeApiResponse) -> [String] {
        listOfNames.removeAll()
        pokeApiResponse.result?.forEach {
            if let name = $0.name {
                listOfNames.append(name)
            }
        }
        return listOfNames
    }
    
}
