//
//  MovesViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class MovesViewController: UIViewController {

    @IBOutlet weak var movesTableView: UITableView! {
        didSet {
            //usersTableView.register(MovesTableViewCell.nib, forCellReuseIdentifier: "cell")
            movesTableView.tableFooterView = UIView()
        }
    }

    var viewModel = MovesViewModel() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

