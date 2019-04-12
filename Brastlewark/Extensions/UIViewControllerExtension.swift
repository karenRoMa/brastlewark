//
//  UIViewControllerExtension.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    
    func showCustomAlert(withText text: String, okText: String, hideCancel: Bool, delegate: AlertDelegate?) {
        let alertVC = AlertViewController()
        alertVC.text = text
        alertVC.okText = okText
        alertVC.hideCancelButton = hideCancel
        alertVC.alertDelegate = delegate
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        
        
        // Controller with another view controller
        if self.parent != nil {
            self.parent?.present(alertVC, animated: true, completion: nil)
            return
        }
        
        // Controller within a navigation controller
        if self.navigationController != nil {
            self.navigationController?.present(alertVC, animated: true, completion: nil)
            return
        }
        
        // Controller within a tab controller
        if self.tabBarController != nil {
            self.tabBarController?.present(alertVC, animated: true, completion: nil)
            return
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    /// Dismiss Keyboard when tap anywhere around the view inside the view controller
    func addDismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    /// Method to dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
