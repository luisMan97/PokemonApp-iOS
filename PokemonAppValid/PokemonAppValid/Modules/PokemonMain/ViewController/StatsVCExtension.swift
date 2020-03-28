//
//  StatsVCExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension StatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfStats == 0 ? tableView.setEmptyMessage(message: "List is empty") : tableView.removeEmptyMessage()

        return viewModel.numberOfStats
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.stats?[indexPath.row].stat?.name
        //cell.detailTextLabel?.text = viewModel.stats?.stat[indexPath.row]?.

        return cell
    }
    
}
