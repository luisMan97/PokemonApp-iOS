//
//  MovesHomeVCExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension MovesHomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfMoves == 0 ? tableView.setEmptyMessage(message: "List is empty") : tableView.removeEmptyMessage()
        
        return viewModel.numberOfMoves
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.moves[indexPath.row].name
        
        return cell
    }
    
}

extension MovesHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*guard let pokemonDetailViewController: PokemonDetailViewController = storyboard?.instantiateViewController(withIdentifier: .pokemonDetail) else { return }
        pokemonDetailViewController.viewModel.pokemon = viewModel.pokemons[indexPath.row]
        navigationController?.pushViewController(pokemonDetailViewController, animated: true)*/
    }
    
}

extension MovesHomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movesTxtSearchBar.resignFirstResponder()
        return true
    }
    
}
