//
//  MovesHomeViewModel.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import Foundation

class MovesHomeViewModel {
    
    // Internal Private Properties
    private let manager = MovesHomeManager()
    
    // Internal Computed Properties
    
    var numberOfMoves: Int {
        return moves.count
    }
    
    var moves: [Move] {
        get {
            return manager.moves
        }
        set {
            manager.moves = newValue
        }
    }
    var originalMovesList: [Move] {
        return manager.originalMovesList
    }
    
    // MARK: - Internal Methods
    
    func getMoves(handler: CallServiceHandler) {
        manager.getMoves(handler: handler)
    }
    
    func search(text: String?) {
        moves.removeAll()
        if text?.count != 0 {
            for move in originalMovesList {
                guard let pokemonToSearch = text else { return }
                let range = move.name?.lowercased().range(of: pokemonToSearch, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    moves.append(move)
                }
            }
        } else {
            for move in originalMovesList {
                moves.append(move)
            }
        }
    }

}
