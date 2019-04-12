//
//  MainCoordinator.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainCoordinator: Coordinator {
    
    // App Window
    var window: UIWindow
    
    // CONTROLLERS
    var rootNavigationController: UINavigationController
    var mainController: MainViewController!
    
    /// View controller push or presented at the top of the app
    var topViewController: UIViewController? {
        if let presentedController = window.rootViewController?.presentedViewController {
            return presentedController
        } else {
            return window.rootViewController
        }
    }
    
    init(window: UIWindow) {
        self.window = window
        rootNavigationController = UINavigationController()
    }
    
    /// Starts coordinator and checks if the user is logged to go to home, otherwise go to Login
    func start() {
        /*
         Show Launch Screen for 3 seconds
         In production case we can download information in
         Launch ViewController
        */

        let launchScreen = LaunchScreenViewController()
        launchScreen.coordinator = self
        self.window.rootViewController = launchScreen
        self.window.makeKeyAndVisible()
    }
    
    @objc func startApp() {
        rootNavigationController = CustomNavigationController()
        mainController = MainViewController()
        mainController?.coordinator = self
        rootNavigationController.pushViewController(mainController!, animated: false)
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = self.rootNavigationController
            self.window.makeKeyAndVisible()
        }, completion: nil)
    }
    
    func goToDetail(with gnome: Gnome) {
        let detailVC = DetailViewController()
        detailVC.gnome = gnome
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .overCurrentContext
        rootNavigationController.present(detailVC, animated: true, completion: nil)
    }

}
