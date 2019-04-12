//
//  AlertViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/13/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

// MARK: - Alert Delegate Declaration -
// ------------------------------------------------------

protocol AlertDelegate: class {
    /// Indicates if the alert should be dismissed before performing the delegate alert, if false the alert will not be dismissed
    var dismissAlertBeforeAction: Bool {get set}
    
    /// Action to perform when the user select the ok button
    func action()
}

/**
 View Controller with an alert design to display mainly errors received from the server.
 It can display any message given and have two buttons:
 - cancel button: Dismiss the alert without any action
 - accept button: Dissmiss or not the alert and perform the action in **Alert Delegate** if is not nil.
*/

class AlertViewController: UIViewController {
    
    // MARK: - Singleton Properties -
    
    /**
     Indicates if an instance of the class ** AlertViewController ** is open
    */
    static var isAlertActive: Bool = false
    
    // MARK: - IBOutlets -
    
    /// Main view containing the label and buttons
    @IBOutlet weak var mainView: UIView!
    /// Label for the message to show
    @IBOutlet weak var titleLabel: UILabel!
    /// Button to cancel and dismiss
    @IBOutlet weak var cancelButton: UIButton!
    /// Button to accept the message and perform action in delegate **AlertDelegate** if exists 🤗
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - Stored Properties -
    
    /// Title text in the alert
    var text: String!
    
    /// Indicates if the cancel button is hidden (Default text: "Cancelar")
    var hideCancelButton: Bool = false
    
    /// Text for the button that close alert and perform any action in delegate
    var okText: String! = "OK"
    
    /// Alert Delegate to perform the ok action
    weak var alertDelegate: AlertDelegate?
    
    // MARK: - View Delegate Methods -

    /// Perform initial configurations in the view
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    /// Set isAlertActive property to true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AlertViewController.isAlertActive = true
    }
    
    /// Set isAlertActive property to false
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AlertViewController.isAlertActive = false
    }
    
    // MARK: - View Configuration -
    
    func configureView() {
        mainView.round(with: 20.0)
        titleLabel.text = text
        cancelButton.isHidden = hideCancelButton
        okButton.setTitle(okText, for: .normal)
    }
    
    // MARK: - IBActions -
    
    /// Action to cancel and dismiss the alert
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /**
     Action to accept the message and perform action if delegate is not nil
     The alert is dismissed depending on the delegate's property  **dismissAlertBeforeAction** and its value
     - if true: will dismiss alert and then perform delegate's method **action()**
     - if false: will just perform delegate's method **action()**
     - if delegate is nil: will just dismiss alert
    */
    @IBAction func accept(_ sender: Any) {
        if let dismissAlert = alertDelegate?.dismissAlertBeforeAction {
            if dismissAlert {
                dismiss(animated: true) {
                    self.alertDelegate?.action()
                }
            } else {
                self.alertDelegate?.action()
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
