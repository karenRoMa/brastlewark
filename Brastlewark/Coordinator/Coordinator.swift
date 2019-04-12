//
//  Coordinator.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    // App Window
    var window: UIWindow { get set }
    
    // Root Controller of the coordinator
    var rootNavigationController: UINavigationController { get set }
    
    func start()
}
