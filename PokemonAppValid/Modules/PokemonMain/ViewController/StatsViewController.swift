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
            statsTableView.rowHeight = 74.5
            statsTableView.register(StatsTableViewCell.nib, forCellReuseIdentifier: "cell")
            statsTableView.isScrollEnabled = false
            statsTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            statsTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var statsTableViewHeightConstraint: NSLayoutConstraint! 
    
    var viewModel = StatsViewModel() 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statsTableViewHeightConstraint.constant = statsTableView.contentSize.height
    }
    
}
