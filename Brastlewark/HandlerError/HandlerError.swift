//
//  HandlerError.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/13/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

class HandlerError {
    
    // MARK: - Singleton Properties -
    
    /// Handle Error shared instance
    static var shared: HandlerError = HandlerError()
    
    // MARK - Stored Properties -
    
    weak var coordinator: MainCoordinator?
    var dismissAlertBeforeAction: Bool = false
    
    private init(){}
    
    func handle(withError error: ErrorType, delegate: AlertDelegate? = nil) {
        guard coordinator != nil else {return}
        DispatchQueue.main.async {
            self.coordinator!.topViewController?.showCustomAlert(withText: error.detailedInfo, okText: "ACEPTAR", hideCancel: true, delegate: delegate)
        }
    }
    
    func showAlert(with text: String, delegate: AlertDelegate? = nil) {
        guard coordinator != nil else {return}
        DispatchQueue.main.async {
            self.coordinator!.topViewController?.showCustomAlert(withText: text, okText: "ACEPTAR", hideCancel: true, delegate: delegate)
        }
    }
}

// MARK: Alert Delegate (go to Login View)
// ------------------------------------------

extension HandlerError: AlertDelegate {
    
    func action() {
        
    }
}
