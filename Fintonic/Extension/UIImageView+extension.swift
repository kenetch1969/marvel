//
//  UIImageView+extension.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImageFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLresponse = response as? HTTPURLResponse, (200...209).contains(httpURLresponse.statusCode),
                let mimetype = response?.mimeType, mimetype.hasPrefix("image"),
                let data = data, error == nil, let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func downloadImageFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadImageFromServer(url: url, contentMode: mode)
    }
}
