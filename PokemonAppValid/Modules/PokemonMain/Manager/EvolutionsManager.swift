//
//  EvolutionsManager.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class EvolutionsManager {
    
    // Internal Properties
    var evolutionChainDetail: EvolutionChainDetail?
    
    private var apiManager = ApiManager()
    
    func getPokemonSpecies(id: Int?, handler: CallServiceHandler) {
        let parameters = ["id": id] as [String: AnyObject]
        
        apiManager.callServiceObject(service: .PokemonSpecies(parameters)) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject] {
                    
                    print("getPokemonSpecies JSON\n", jsonResult)
                    
                    let pokemonSpecies = PokemonSpecies(JSON: jsonResult)
                    
                    let urlEvolutionChain = pokemonSpecies?.evolutionChain?.url
                    
                    strongSelf.getEvolutionChain(urlEvolutionChain: urlEvolutionChain, handler: handler)
                    
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getEvolutionChain(urlEvolutionChain: String?, handler: CallServiceHandler) {
        guard let url = urlEvolutionChain else {
            handler?(nil, nil)
            return
        }
        
        apiManager.callSimpleGet(url: url) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject] {
                    
                    print("getEvolutionChain JSON\n", jsonResult)
                    
                    strongSelf.evolutionChainDetail = EvolutionChainDetail(JSON: jsonResult)
                    
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }

}
