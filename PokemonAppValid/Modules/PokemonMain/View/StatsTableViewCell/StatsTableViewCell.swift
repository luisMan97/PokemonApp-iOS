//
//  StatsTableViewCell.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var baseStatLAbel: UILabel!
    @IBOutlet weak var baseStatProgressView: UIProgressView!
    
    var stat: Stat? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    private func setup() {
        
        statLabel.text = stat?.stat?.name
        if let baseStat = stat?.baseStat {
            var baseStatString = ""
            
            baseStatLAbel.text = String(baseStat)
            
            if baseStat < 10 {
                baseStatString = "00.\(baseStat)"
            } else if baseStat > 99 {
                baseStatString = "\(baseStat)"
            } else {
                baseStatString = "0.\(baseStat)"
            }
            
            baseStatProgressView.progress = (baseStatString as NSString).floatValue // On iOS 13, convertion of string to float using Float(value) returns nil
        } else {
            baseStatLAbel.text = "00"
        }
        
    }
    
}
