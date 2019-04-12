//
//  FontType.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

enum FontType: String {
    case none = ""
    case heavy = "Heavy"
    case oblique = "Oblique"
    case black = "Black"
    case book = "Book"
    
    var fontName: String {
        return "Avenir"
    }
    
    var fullString: String {
        if self == .none {
            return fontName
        }
        return "\(fontName)-\(self.rawValue)"
    }
}
