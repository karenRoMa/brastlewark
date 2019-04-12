//
//  UIButtonExtension.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import pop

extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.addBounceAnimationTargets()
    }
    
    /// Add bounce animation to button
    func addBounceAnimationTargets() {
        self.addTarget(self, action: #selector(buttonPressed), for: [.touchDown])
        self.addTarget(self, action: #selector(buttonReleased), for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    /// Contract the button view
    @objc func buttonPressed(_ sender: UIButton) {
        sender.contract(withDuration: 0.1) { _, _ in}
    }
    
    /// Expands the button view
    @objc func buttonReleased(_ sender: UIButton) {
        sender.expand(withBounce: 10.0)
    }
    
}
