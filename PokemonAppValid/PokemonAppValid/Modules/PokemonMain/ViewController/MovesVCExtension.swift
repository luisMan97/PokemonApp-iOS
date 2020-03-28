//
//  MovesVCExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension MovesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfMoves == 0 ? tableView.setEmptyMessage(message: "List is empty") : tableView.removeEmptyMessage()

        return viewModel.numberOfMoves
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.moves?[indexPath.row].move?.name

        return cell
    }
    
}
