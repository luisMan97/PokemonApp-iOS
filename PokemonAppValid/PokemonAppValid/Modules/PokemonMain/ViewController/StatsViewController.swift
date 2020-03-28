//
//  StatsViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class StatsViewController: UIViewController {

    @IBOutlet weak var statsTableView: UITableView! {
        didSet {
            //usersTableView.register(MovesTableViewCell.nib, forCellReuseIdentifier: "cell")
            statsTableView.tableFooterView = UIView()
        }
    }

    var viewModel = StatsViewModel() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
