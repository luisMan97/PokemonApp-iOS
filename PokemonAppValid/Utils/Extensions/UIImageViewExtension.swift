//
//  UIImageViewExtensions.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

extension UIImageView {
    
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, onComplete: ((_ onSuccess: Bool) -> Void)?) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                onComplete?(true)
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, onComplete: ((_ onSuccess: Bool) -> Void)?) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode) { succes in
            onComplete?(true)
        }
    }
}

