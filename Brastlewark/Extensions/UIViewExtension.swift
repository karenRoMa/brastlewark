//
//  UIViewExtension.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

extension UIView {
    
    func round(with radius: CGFloat? = nil) {
        if radius != nil {
            layer.cornerRadius = radius!
        } else {
            layer.cornerRadius = self.bounds.height/2
        }
        layer.masksToBounds = true
    }
}
