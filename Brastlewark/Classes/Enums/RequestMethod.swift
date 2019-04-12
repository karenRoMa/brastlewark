//
//  RequestMethod.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case post
    case get
    case put
    case delete
    
    // String value uppercased
    var value: String {
        return self.rawValue.uppercased()
    }
}
