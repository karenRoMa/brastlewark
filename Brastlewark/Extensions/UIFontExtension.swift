//
//  UIFontExtension.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

extension UIFont {
    class func avenir(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.fullString, size: size)!
    }
}
