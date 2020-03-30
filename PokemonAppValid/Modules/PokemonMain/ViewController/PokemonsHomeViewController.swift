//
//  PokemonsHomeViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class PokemonsHomeViewController: UIViewController {

    @IBOutlet weak var txtSearchBar: UITextField! {
        didSet {
            txtSearchBar.addTarget(self, action: #selector(searchPokemons(_ :)), for: .editingChanged)
            txtSearchBar.delegate = self
        }
    }
    @IBOutlet weak var pokemonsTableView: UITableView! {
        didSet {
            pokemonsTableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: "cell")
            pokemonsTableView.tableFooterView = UIView()
        }
    }

    let viewModel = PokemonsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokemonsTableView.rowHeight = pokemonsTableView.frame.height / 3
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        txtSearchBar.resignFirstResponder()
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemons()
    }
    
    @objc private func searchPokemons(_ textField: UITextField) {
        viewModel.search(text: textField.text)
        pokemonsTableView.reloadData()
    }

    private func getPokemons() {
        KVNProgress.show()
        viewModel.getPokemons() { [weak self] (success, error) in
            KVNProgress.dismiss()
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.pokemonsTableView.reloadData()
                }
            }
        }
    }
    
}
