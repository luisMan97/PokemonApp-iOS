//
//  ItemsVCExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems == 0 ? tableView.setEmptyMessage(message: "List is empty") : tableView.removeEmptyMessage()
        
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.item = viewModel.items[indexPath.row]
        
        return cell
    }
    
}

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*guard let pokemonDetailViewController: PokemonDetailViewController = storyboard?.instantiateViewController(withIdentifier: .pokemonDetail) else { return }
         pokemonDetailViewController.viewModel.pokemon = viewModel.pokemons[indexPath.row]
         navigationController?.pushViewController(pokemonDetailViewController, animated: true)*/
    }
    
}

extension ItemsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
    
}

