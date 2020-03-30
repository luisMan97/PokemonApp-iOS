//
//  ItemsManager.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import ObjectMapper

class ItemsManager {
    
    // Internal Properties
    var items: [Item] = []
    var originalItemsList: [Item] = []
    
    private var listOfNames = [""]
    
    // Internal Private Properties
    private let apiManager = ApiManager()
    
    // MARK: - Internal Methods
    
    func getItems(handler: CallServiceHandler) {
        apiManager.callServiceObject(service: .Items) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let itemListResponse = ItemListRessponse(JSON: jsonResult) {
                    
                    //print("getPokemons JSON\n", jsonResult)
                    strongSelf.getDataForEachItem(itemListResponse: itemListResponse, handler: handler)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getDataForEachItem(itemListResponse: ItemListRessponse, handler: CallServiceHandler) {
        var listOfNames = getListOfNames(itemListResponse)
        listOfNames.removeLast()
        let originalListOfNames = getListOfNames(itemListResponse)
        
        items.removeAll()
        
        listOfNames.forEach {
            let parameters = ["name": $0] as [String: AnyObject]
            apiManager.callServiceObject(service: .Item(parameters)) { [weak self] (result, error) in
                guard let strongSelf = self else {
                    handler?(nil, nil)
                    return
                }
                if let error = error {
                    handler?(false, error)
                } else if let result = result {
                    if let jsonResult = result as? [String: AnyObject],
                        let item = Item(JSON: jsonResult) {
                        strongSelf.getImage(item: item, handler: handler)
                    } else {
                        handler?(nil, nil)
                    }
                } else {
                    handler?(nil, nil)
                }
            }
        }
        
        let parameters = ["name": originalListOfNames.last] as [String: AnyObject]
        
        apiManager.callServiceObject(service: .Item(parameters)) { [weak self] (result, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            if let error = error {
                handler?(false, error)
            } else if let result = result {
                if let jsonResult = result as? [String: AnyObject],
                    let item = Item(JSON: jsonResult) {
                    strongSelf.getImage(item: item, handler: handler)
                    handler?(true, nil)
                } else {
                    handler?(nil, nil)
                }
            } else {
                handler?(nil, nil)
            }
        }
    }
    
    private func getImage(item: Item, handler: CallServiceHandler) {
        apiManager.callImage(url: item.sprite?.defaultSprite ?? "") { [weak self] (data, error) in
            guard let strongSelf = self else {
                handler?(nil, nil)
                return
            }
            
            if let error = error {
                handler?(false, error)
            } else if let data = data, var jsonItem = (item.toJSON() as NSDictionary) as? [String: AnyObject] {
                jsonItem["image"] = data as AnyObject
                guard let item = Item(JSON: jsonItem) else { return }
                strongSelf.items.append(item)
                strongSelf.originalItemsList.append(item)
                handler?(true, nil)
            } else {
                handler?(nil, nil)
            }
            
        }
    }
    
    private func getListOfNames(_ itemListResponse: ItemListRessponse) -> [String] {
        listOfNames.removeAll()
        itemListResponse.result?.forEach {
            if let name = $0.name {
                listOfNames.append(name)
            }
        }
        return listOfNames
    }

}
