//
//  PokemonsHomeVCExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension PokemonsHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfPokemons == 0 ? tableView.setEmptyMessage(message: "List is empty") : tableView.removeEmptyMessage()
        
        return viewModel.numberOfPokemons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
       
        cell.pokemon = viewModel.pokemons[indexPath.row]
        //cell.pokemonImage.image = UIImage(data: viewModel.dataImages[indexPath.row])
        //cell.tapViewPostsAction = tapViewPostsAction

        return cell
    }
    
}

extension PokemonsHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemonDetailViewController: PokemonDetailViewController = storyboard?.instantiateViewController(withIdentifier: .pokemonDetail) else { return }
        pokemonDetailViewController.viewModel.pokemon = viewModel.pokemons[indexPath.row]
        //txtSearchBar.resignFirstResponder()
        navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }
    
}

extension PokemonsHomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
    
}

private extension PokemonsHomeViewController {

    /*func tapViewPostsAction(_ cell: UITableViewCell) -> () {
        guard let pokemonDetailViewController: PokemonDetailViewController = storyboard?.instantiateViewController(withIdentifier: .pokemonDetail),
            let indexPath = pokemonsTableView.indexPath(for: cell) else { return }
        pokemonDetailViewController.viewModel.pokemon = viewModel.pokemons[indexPath.row]
        txtSearchBar.resignFirstResponder()
        navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }*/

}
