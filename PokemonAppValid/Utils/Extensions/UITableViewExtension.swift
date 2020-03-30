//
//  UITableViewExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(message: String) {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: bounds.size.width, height: bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 13, weight: .regular)
        messageLabel.sizeToFit()
        backgroundView = messageLabel
        separatorStyle = .none
    }
    
    func removeEmptyMessage() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
    
}