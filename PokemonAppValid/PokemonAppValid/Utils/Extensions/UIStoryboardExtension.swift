//
//  UIStoryboardExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /**
     - Author: Jorge Luis Rivera Ladino
     - Note: Use this function only when the view controller to be instantiated is in the same storyboard of the controller you are instantiating
     */
    func instantiateViewController<T: UIViewController>(withIdentifier: SegueIdentifier) -> T? {
        
        let indentifier = withIdentifier.rawValue
        
        return self.instantiateViewController(withIdentifier: indentifier) as? T
    }
    
}