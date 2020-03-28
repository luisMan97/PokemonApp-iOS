//
//  UIViewExtension.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Layer
    
    func removeLayer(withName: String) {
        self.layer.sublayers?.forEach { layer in
            if layer.name == withName {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    // MARK: - Round
    
    func roundSides() {
        layer.cornerRadius = bounds.height / 2
    }
    
    func cornerRadiusWith(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat)  {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func roundTopCornersWith(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        if #available(iOS 11.0, *) {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner,
                                   .layerMaxXMinYCorner]
            
            layer.borderColor = borderColor
            layer.borderWidth = borderWidth
            
            clipsToBounds = true
        } else {
            self.removeLayer(withName: "borderLayer")
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
            
            let borderPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let borderLayer = CAShapeLayer()
            borderLayer.path = borderPath.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.frame = bounds
            borderLayer.name = "borderLayer"
            layer.addSublayer(borderLayer)
        }
    }
    
    func roundBottomCornersWith(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        if #available(iOS 11.0, *) {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner,
                                   .layerMaxXMaxYCorner]
            
            layer.borderColor = borderColor
            layer.borderWidth = borderWidth
            
            clipsToBounds = true
        } else {
            self.removeLayer(withName: "borderLayer")
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
            
            let borderPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let borderLayer = CAShapeLayer()
            borderLayer.path = borderPath.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.frame = bounds
            borderLayer.name = "borderLayer"
            layer.addSublayer(borderLayer)
        }
    }
    
    func roundAllCornersWith(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        if #available(iOS 11.0, *) {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner,
                                   .layerMaxXMinYCorner,
                                   .layerMinXMaxYCorner,
                                   .layerMaxXMaxYCorner]
            
            layer.borderColor = borderColor
            layer.borderWidth = borderWidth
            
            clipsToBounds = true
        } else {
            self.removeLayer(withName: "borderLayer")
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
            
            let borderPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let borderLayer = CAShapeLayer()
            
            borderLayer.path = borderPath.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.frame = bounds
            borderLayer.name = "borderLayer"
            layer.addSublayer(borderLayer)
        }
    }
    
    // MARK: - Auto layout
    
    func fixInViewWithConstraint(_ container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        //frame = container.frame
        
        container.addSubview(self)
        
        activateNSLayoutAnchor(container)
    }
    
    func activateNSLayoutAnchor(_ container: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
    }

    // MARK: - Load nib for cell
    
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    // MARK: - Load nib
    
    public class var nibName: String {
        let name = String(describing: self).components(separatedBy: ".").first ?? ""
        return name
    }

}
