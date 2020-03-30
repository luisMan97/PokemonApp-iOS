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
    @IBOutlet weak var megaStoneLabel: UILabel!
    
    @IBOutlet weak var secondRow: UIImageView!
    @IBOutlet weak var lastRow: UIImageView!
    
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var lastStackView: UIStackView!
    
    @IBOutlet weak var stackViewContainerLayoutConstraint: NSLayoutConstraint!
    
    let viewModel = EvolutionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonSpecies()
     }

    private func getPokemonSpecies() {
        KVNProgress.show()
        viewModel.getPokemonSpecies() { [weak self] (success, error) in
            guard let strongSelf = self else {
                KVNProgress.dismiss()
                return
            }
            
            if let error = error {
                KVNProgress.dismiss()
                strongSelf.presentAlertError(error)
            } else if let success = success {
                if success {
                    strongSelf.updateUI()
                }
            } else {
                KVNProgress.dismiss()
            }
        }
    }
    
    private func updateUI() {
        let firstName = viewModel.evolutionChainDetail?.chain?.species?.name
        let secondName = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.species?.name
        let fourthName = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.species?.name
        let sixthName = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.envolvesTo?.first?.species?.name
        
        let levelOne = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.evolutionsDetails?.first?.minLevel ?? 0
        let levelTwo = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.evolutionsDetails?.first?.minLevel ?? 0
        
        firstSpecieLabel.text = firstName
        secondSpecieLabel.text = secondName
        
        lvOneLabel.text = "Lv. \(levelOne)"
        
        thirdSpecieLabel.text = secondSpecieLabel.text
        fourthSpecieLabel.text = fourthName
        
        lvTwoLabel.text = "Lv. \(levelTwo)"
        
        fifthSpecieLabel.text = fourthSpecieLabel.text
        sixthSpecieLabel.text = sixthName
        
        if sixthName != nil {
            megaStoneLabel.isHidden = false
            lastRow.isHidden = false
            lastStackView.isHidden = false
            stackViewContainerLayoutConstraint.constant = 607
        } else {
            megaStoneLabel.isHidden = true
            lastRow.isHidden = true
            lastStackView.isHidden = true
            stackViewContainerLayoutConstraint.constant = 419
        }
        
        if fourthName != nil {
            lvTwoLabel.isHidden = false
            secondRow.isHidden = false
            secondStackView.isHidden = false
            stackViewContainerLayoutConstraint.constant = 419
        } else {
            lvTwoLabel.isHidden = true
            secondRow.isHidden = true
            secondStackView.isHidden = true
            stackViewContainerLayoutConstraint.constant = 231
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileId = fileArray.last {
                if viewModel.pokemon?.name == firstName,
                    let image = viewModel.pokemon?.image {
                    firstSpecieImage.image = UIImage(data: image)
                } else {
                    firstSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileId).png", onComplete: nil)
                }
            }
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileId = fileArray.last {
                if viewModel.pokemon?.name == secondName,
                    let image = viewModel.pokemon?.image {
                    secondSpecieImage.image = UIImage(data: image)
                    thirdSpecieImage.image = secondSpecieImage.image
                } else {
                    secondSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileId).png") { _ in
                        self.thirdSpecieImage.image = self.secondSpecieImage.image
                    }
                }
            }
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileId = fileArray.last {
                if viewModel.pokemon?.name == fourthName,
                    let image = viewModel.pokemon?.image {
                    KVNProgress.dismiss()
                    fourthSpecieImage.image = UIImage(data: image)
                    fifthSpecieImage.image = fourthSpecieImage.image
                } else {
                    fourthSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileId).png") { _ in
                        KVNProgress.dismiss()
                        self.fifthSpecieImage.image = self.fourthSpecieImage.image
                    }
                }
            } else {
                KVNProgress.dismiss()
            }
        } else {
            KVNProgress.dismiss()
            // TODO: Hide thirdSpecieImage and fourthSpecieImage
        }
        
        if let url = viewModel.evolutionChainDetail?.chain?.envolvesTo?.first?.envolvesTo?.first?.envolvesTo?.first?.species?.url {
            var fileArray = url.components(separatedBy: "/")
            fileArray.removeLast()
            if let finalFileId = fileArray.last {
                if viewModel.pokemon?.name == sixthName,
                    let image = viewModel.pokemon?.image {
                    sixthSpecieImage.image = UIImage(data: image)
                } else {
                    sixthSpecieImage.downloaded(from: "https://pokeres.bastionbot.org/images/pokemon/\(finalFileId).png", onComplete: nil)
                }
            }
        }
        
    }
    
}
