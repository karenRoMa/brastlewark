//
//  URLExtension.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/10/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    func downloadImage(imageCache: NSCache<NSString, UIImage>, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: self.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            URLSession.shared.dataTask(with: self) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: self.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, nil)
                }
            }.resume()
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: self) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data))
            }
        }.resume()
    }

}
