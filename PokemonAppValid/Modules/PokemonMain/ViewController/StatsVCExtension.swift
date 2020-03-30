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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StatsTableViewCell else {
            return UITableViewCell()
        }
       
        cell.stat = viewModel.stats?[indexPath.row]

        return cell
    }
    
}
