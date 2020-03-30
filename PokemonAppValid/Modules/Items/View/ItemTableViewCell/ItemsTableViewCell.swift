//
//  ItemsTableViewCell.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 29/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTextLabel: UILabel!
    
    var item: Item? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    private func setup() {
        itemTextLabel.text = item?.name
        if let image = item?.image {
            itemImage.image = UIImage(data: image)
        }
    }
    
}
