//
//  UIViewControllerExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Remove the back button title from the all navigation bars
    
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Utils
    
    func presentAlertWith(title: String = "", message: String, leftActionText: String? = nil, rightActionText: String? = nil, leftHandler: AlertActionHandler = nil, rightHandler: AlertActionHandler = nil) {
        let alert = UIAlertController.alertWith(title: title, message: message, leftActionText: leftActionText, rightActionText: rightActionText, leftHandler: leftHandler, rightHandler: rightHandler)
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlertError(_ error: Error, title: String = "error", rightHandler: AlertActionHandler = nil) {
        presentAlertWith(title: title, message: error.localizedDescription, rightHandler: rightHandler)
    }
    
    func presentAlertErrorWith(title: String = "error", message: String, rightHandler: AlertActionHandler = nil) {
        presentAlertWith(title: title, message: message, rightHandler: rightHandler)
    }
    
    // MARK: - Add and remove View Controller to/from cantainer view
    
    func addChild(childController: UIViewController, to containerView: UIView, withAutomaticHeight: Bool = true) {
        addChild(childController)
        
        if withAutomaticHeight {
            childController.view.fixInViewWithConstraint(containerView)
        } else {
            childController.view.frame = containerView.bounds
            containerView.addSubview(childController.view)
        }
        
        childController.didMove(toParent: self)
    }
    
    func remove(childController: UIViewController) {
        childController.willMove(toParent: nil)
        
        childController.view.removeFromSuperview()
        
        childController.removeFromParent()
    }
    
}
