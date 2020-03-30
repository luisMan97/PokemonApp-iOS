//
//  ItemsViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import Foundation

class ItemsViewModel {
    
    // Internal Private Properties
    private let manager = ItemsManager()
    
    // Internal Computed Properties
    
    var items: [Item] {
        get {
            return manager.items
        }
        set {
            manager.items = newValue
        }
    }
    var originalItemsList: [Item] {
        return manager.originalItemsList
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    // MARK: - Internal Methods
    
    func getItems(handler: CallServiceHandler) {
        manager.getItems(handler: handler)
    }
    
    func search(text: String?) {
        items.removeAll()
        if text?.count != 0 {
            for item in originalItemsList {
                guard let pokemonToSearch = text else { return }
                let range = item.name?.lowercased().range(of: pokemonToSearch, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    items.append(item)
                }
            }
        } else {
            for item in originalItemsList {
                items.append(item)
            }
        }
    }
    
}
