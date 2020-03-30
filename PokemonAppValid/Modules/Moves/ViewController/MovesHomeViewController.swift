//
//  MovesViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class MovesHomeViewController: UIViewController {
    
    @IBOutlet weak var movesTxtSearchBar: UITextField! {
        didSet {
            movesTxtSearchBar.addTarget(self, action: #selector(searchMoves(_ :)), for: .editingChanged)
            movesTxtSearchBar.delegate = self
        }
    }
    @IBOutlet weak var movesTableView: UITableView! {
        didSet {
            movesTableView.rowHeight = 74.5
            //movesTableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: "cell")
            movesTableView.tableFooterView = UIView()
        }
    }
    
    let viewModel = MovesHomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movesTxtSearchBar.resignFirstResponder()
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoves()
    }
    
    @objc private func searchMoves(_ textField: UITextField) {
        viewModel.search(text: textField.text)
        movesTableView.reloadData()
    }
    
    private func getMoves() {
        KVNProgress.show()
        viewModel.getMoves() { [weak self] (success, error) in
            KVNProgress.dismiss()
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.movesTableView.reloadData()
                }
            }
        }
    }
    
}
