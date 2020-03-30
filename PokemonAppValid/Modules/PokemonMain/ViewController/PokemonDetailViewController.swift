//
//  PokemonDetailViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var typeButton: UIButton! {
        didSet {
            typeButton.setTitle(viewModel.pokemon?.types?.first?.type?.name, for: .normal)
            typeButton.isEnabled = false
            typeButton.roundSides()
        }
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.roundAllCornersWith(borderColor: UIColor.white.cgColor, borderWidth: 0, cornerRadius: 48)
        }
    }
    @IBOutlet weak var backgroundButtons: UIView! {
        didSet {
            backgroundButtons.roundSides()
        }
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet { 
            nameLabel.text = viewModel.pokemon?.name
        }
    }
    @IBOutlet weak var efecctAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var animationsButtons: [UIButton]! {
        didSet {
            animationsButtons.first?.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var animationLayoutConstraint: NSLayoutConstraint!
    
    let viewModel = PokemonViewModel()

    var statsViewController: StatsViewController?
    var evolutionsViewController: EvolutionsViewController?
    var movesViewController: MovesViewController?

    // Observers Private Properties
    private var activeViewController: UIViewController? {
        didSet {
            remove(inactiveViewController: oldValue)
            updateActiveController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.pokemon?.name
        navigationController?.navigationBar.tintColor = .white
        setChildsViewControllers()
        getImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func statsAction(_ sender: Any) {
        showStatsViewController()
    }
    
    @IBAction func evolutionsAction(_ sender: Any) {
        showEvolutionsViewController()
    }
    
    @IBAction func movesAction(_ sender: Any) {
        showMovesViewController()
    }
    
    @IBAction func animateHeader(_ sender: UIButton) {
        animationLayoutConstraint.constant = sender.frame.origin.x
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { completed in
            self.animationsButtons.forEach {
                $0.setTitleColor(#colorLiteral(red: 0.3333333333, green: 0.6196078431, blue: 0.8745098039, alpha: 1), for: .normal)
                sender.setTitleColor(.white, for: .normal)
            }
        })
    }
    
    private func getImage() {
        KVNProgress.show()
        if let id = viewModel.pokemon?.id {
            pokemonImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(id).png") { success in
                KVNProgress.dismiss()
                self.getAbilities()
            }
        } else if let frontDefault = viewModel.pokemon?.sprite?.frontDefault {
            pokemonImage.downloaded(from: frontDefault) { success in
                KVNProgress.dismiss()
                self.getAbilities()
            }
        }
    }

    private func setChildsViewControllers() {
        statsViewController = storyboard?.instantiateViewController(withIdentifier: .stats)
        evolutionsViewController = storyboard?.instantiateViewController(withIdentifier: .evolutions)
        movesViewController = storyboard?.instantiateViewController(withIdentifier: .moves)
    }
    
    private func remove(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            remove(childController: inactiveVC)
        }
    }
    
    private func updateActiveController() {
        if let activeVC = activeViewController {
            addChild(childController: activeVC, to: containerView)
        }
    }
    
    private func showStatsViewController() {
        if activeViewController == statsViewController {
            return
        }
        
        statsViewController?.viewModel.stats = viewModel.pokemon?.stats
        
        activeViewController = statsViewController
    }
    
    private func showEvolutionsViewController() {
        if activeViewController == evolutionsViewController {
            return
        }
        
        evolutionsViewController?.viewModel.id = viewModel.pokemon?.id
        
        activeViewController = evolutionsViewController
    }

    private func showMovesViewController() {
        if activeViewController == movesViewController {
            return
        }
        
        movesViewController?.viewModel.moves = viewModel.pokemon?.moves
        
        activeViewController = movesViewController
    }

    private func getAbilities() {
        viewModel.getAbilities() { [weak self] (success, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.efecctAbilitiesLabel.text = strongSelf.viewModel.ability?.effectEntries?.first?.effect
                    strongSelf.showStatsViewController()
                }
            }
        }
    }
    
}
