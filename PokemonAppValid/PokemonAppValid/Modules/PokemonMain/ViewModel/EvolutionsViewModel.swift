//
//  PokemonViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class EvolutionsViewModel {

    // Internal Properties
    var id: Int? 
    var evolutionChainDetail: EvolutionChainDetail?
    
    private var apiManager = ApiManager()
    private var urlEvolutionChain: String?

    func getPokemonSpecies(handler: CallServiceHandler) {
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

                    strongSelf.urlEvolutionChain = pokemonSpecies?.evolutionChain?.url
                        
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    func getEvolutionChain(handler: CallServiceHandler) {
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
