//
//  PokemonViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

class PokemonViewModel {

    // Internal Properties
    var pokemon: Pokemon?
    var ability: Ability?
    
    private let apiManager = ApiManager()
    
    func getAbilities(handler: CallServiceHandler) {
        let parameters = ["id": pokemon?.id] as [String: AnyObject]
        apiManager.callServiceObject(service: .Ability(parameters)) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject] {
                    
                    //print("getAbilities JSON\n", jsonResult)
                    
                    strongSelf.ability = Ability(JSON: jsonResult)
                    
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
