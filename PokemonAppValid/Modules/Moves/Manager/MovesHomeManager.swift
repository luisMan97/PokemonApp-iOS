//
//  MovesHomeManager.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class MovesHomeManager {
    
    // Internal Properties
    var moves: [Move] = []
    var originalMovesList: [Move] = []
    
    private var listOfNames = [""]
    
    // Internal Private Properties
    private let apiManager = ApiManager()
    
    // MARK: - Internal Methods
    
    func getMoves(handler: CallServiceHandler) {
        apiManager.callServiceObject(service: .Moves) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let moveListResponse = MoveListRessponse(JSON: jsonResult) {
                    
                    //print("getPokemons JSON\n", jsonResult)
                    strongSelf.getDataForEachMove(moveListResponse: moveListResponse, handler: handler)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getDataForEachMove(moveListResponse: MoveListRessponse, handler: CallServiceHandler) {
        var listOfNames = getListOfNames(moveListResponse)
        listOfNames.removeLast()
        let originalListOfNames = getListOfNames(moveListResponse)
        
        moves.removeAll()
        
        listOfNames.forEach {
            let parameters = ["name": $0] as [String: AnyObject]
            apiManager.callServiceObject(service: .Move(parameters)) { [weak self] (result, error) in
                guard let strongSelf = self else {
                    handler?(nil, nil)
                    return
                }
                if let error = error {
                    handler?(false, error)
                } else if let result = result {
                    if let jsonResult = result as? [String: AnyObject],
                        let pokemon = Move(JSON: jsonResult) {
                        strongSelf.moves.append(pokemon)
                        strongSelf.originalMovesList.append(pokemon)
                    } else {
                        handler?(nil, nil)
                    }
                } else {
                    handler?(nil, nil)
                }
            }
        }
        
        let parameters = ["name": originalListOfNames.last] as [String: AnyObject]
        
        apiManager.callServiceObject(service: .Move(parameters)) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let pokemon = Move(JSON: jsonResult) {
                    strongSelf.moves.append(pokemon)
                    strongSelf.originalMovesList.append(pokemon)
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getListOfNames(_ moveListRessponse: MoveListRessponse) -> [String] {
        listOfNames.removeAll()
        moveListRessponse.result?.forEach {
            if let name = $0.name {
                listOfNames.append(name)
            }
        }
        return listOfNames
    }


}
