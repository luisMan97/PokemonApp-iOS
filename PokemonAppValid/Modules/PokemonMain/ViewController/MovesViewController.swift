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
            movesTableView.rowHeight = 75
            movesTableView.isScrollEnabled = false
            movesTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            movesTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var movesTableViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel = MovesViewModel() 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movesTableViewHeightConstraint.constant = movesTableView.contentSize.height
    }
    
}

