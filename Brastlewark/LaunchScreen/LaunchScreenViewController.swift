//
//  LaunchScreenViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/20/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit
import Lottie
import RealmSwift
import SwiftyJSON

class LaunchScreenViewController: UIViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var animationView: UIView!
    
    // MARK: - Stored Properties -
    
    weak var coordinator: MainCoordinator?
    
    // Realm Instance
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        downloadData()
    }
    
    func configureView() {
        
        // Load Lottie view
        let lottieView = AnimationView(name: "monster")
        lottieView.bounds = CGRect(x: 0, y: 0, width: animationView.bounds.width, height: animationView.bounds.height)
        lottieView.frame = animationView.bounds
        lottieView.clipsToBounds = true
        animationView.addSubview(lottieView)
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    func downloadData() {
        Router.getData.performRequest { (response) in
            DispatchQueue.main.async {
                if let jsonArray = response?["Brastlewark"].array {
                    var gnomes: [Gnome] = []
                    for gnomeJSON in jsonArray {
                        let newGnome = Gnome(with: gnomeJSON)
                        gnomes.append(newGnome)
                    }
                    
                    try! self.realm.write {
                        self.realm.add(gnomes, update: true)
                        
                        self.coordinator?.startApp()
                    }
                }
            }
        }
    }

}
