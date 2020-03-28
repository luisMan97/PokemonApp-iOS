//
//  PokemonsViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 24/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class PokemonsViewModel {

    // Internal Properties
    var pokemons: [Pokemon] = []
    var originalPokemonsList: [Pokemon] = []
    var dataImages: [Data] = []
    
    private var listOfNames = [""]
    
    // Internal Private Properties
    private let apiManager = ApiManager()

    // Internal Computed Properties
    
    var numberOfPokemons: Int {
        return pokemons.count
    }

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
                        let pokemon = Pokemon(JSON: jsonResult) {
                        strongSelf.pokemons.append(pokemon)
                        strongSelf.originalPokemonsList.append(pokemon)
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
                    let pokemon = Pokemon(JSON: jsonResult) {
                    strongSelf.pokemons.append(pokemon)
                    strongSelf.originalPokemonsList.append(pokemon)
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getImageForEachPokemon(handler: CallServiceHandler) {
        let originalPokemons = pokemons
        pokemons.removeLast()
        
        dataImages.removeAll()
        
        pokemons.forEach {
            if let id = $0.id {
                apiManager.callImage(url: "https://pokeres.bastionbot.org/images/pokemon/\(id).png") { [weak self] (data, error) in
                    guard let strongSelf = self else {
                        handler?(nil, nil)
                        return
                    }
                    if let error = error {
                        handler?(false, error)
                    } else if let result = data as? Data {
                        strongSelf.dataImages.append(result)
                        print("Imagenes Hay: ", strongSelf.dataImages.count)
                    } else {
                        handler?(nil, nil)
                    }
                }
            }
        }
        
        apiManager.callImage(url: "https://pokeres.bastionbot.org/images/pokemon/\(originalPokemons.last?.id ?? 0).png") { [weak self] (data, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            if let error = error {
                handler?(false, error)
            } else if let result = data as? Data {
                strongSelf.dataImages.append(result)
                print("Imagenes Hay: ", strongSelf.dataImages.count)
                handler?(true, nil)
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
