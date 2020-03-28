//
//  PokemonDetailViewController.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import KVNProgress

class EvolutionsViewController: UIViewController {
    
    @IBOutlet weak var firstSpecieLabel: UILabel!
    @IBOutlet weak var secondSpecieLabel: UILabel!
    @IBOutlet weak var thirdSpecieLabel: UILabel!
    @IBOutlet weak var fourthSpecieLabel: UILabel!
    @IBOutlet weak var fifthSpecieLabel: UILabel!
    @IBOutlet weak var sixthSpecieLabel: UILabel!
    @IBOutlet weak var firstSpecieImage: UIImageView!
    @IBOutlet weak var secondSpecieImage: UIImageView!
    @IBOutlet weak var thirdSpecieImage: UIImageView!
    @IBOutlet weak var fourthSpecieImage: UIImageView!
    @IBOutlet weak var fifthSpecieImage: UIImageView!
    @IBOutlet weak var sixthSpecieImage: UIImageView!
    @IBOutlet weak var lvOneLabel: UILabel!
    @IBOutlet weak var lvTwoLabel: UILabel!
    @IBOutlet weak var lastStackView: UIStackView!
    @IBOutlet weak var megaStoneLabel: UILabel!
    @IBOutlet weak var lastRow: UIImageView!
    
    let viewModel = EvolutionsViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPokemonSpecies()
    }

    private func getPokemonSpecies() {
        KVNProgress.show()
        viewModel.getPokemonSpecies() { [weak self] (success, error) in
            KVNProgress.dismiss()
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.getEvolutionChain()
                }
            }
        }
    }

    private func getEvolutionChain() {
        KVNProgress.show()
        viewModel.getEvolutionChain() { [weak self] (success, error) in
            KVNProgress.dismiss()
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.updateUI()
                }
            }
        }
    }
    
    private func updateUI() {
        firstSpecieLabel.text = viewModel.evolutionChainDetail?.chain?.species?.name
        secondSpecieLabel.text = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.species?.name
        
        lvOneLabel.text = "Lv. \(viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.evolutionsDetails?.first?.minLevel ?? 0)"
        
        thirdSpecieLabel.text = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.species?.name
        fourthSpecieLabel.text = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.species?.name
        
        lvTwoLabel.text = "Lv. \(viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.evolutionsDetails?.first?.minLevel ?? 0)"
        
        if let name = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.envolvesTo?.first?.species?.name {
            megaStoneLabel.isHidden = false
            lastRow.isHidden = false
            fifthSpecieLabel.isHidden = false
            sixthSpecieLabel.isHidden = false
            fifthSpecieLabel.text = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.species?.name
            sixthSpecieLabel.text = name
        } else {
            megaStoneLabel.isHidden = true
            lastRow.isHidden = true
            fifthSpecieLabel.isHidden = true
            sixthSpecieLabel.isHidden = true
            fifthSpecieImage.isHidden = true
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileName = fileArray.last {
                //KVNProgress.show()
                firstSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileName).png", onComplete: nil)
            }
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileName = fileArray.last {
                secondSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileName).png") { _ in
                    self.thirdSpecieImage.image = self.secondSpecieImage.image
                }
            }
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileName = fileArray.last {
                fourthSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileName).png") { _ in
                    //KVNProgress.dismiss()
                    self.fifthSpecieImage.image = self.fourthSpecieImage.image
                }
            }
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileName = fileArray.last {
                fourthSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileName).png", onComplete: nil)
            }
        }
        
    }
    
}
