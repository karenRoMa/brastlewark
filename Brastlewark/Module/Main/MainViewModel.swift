//
//  MainViewModel.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/9/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Protocol ViewModel Declaration -
//-------------------------------------------------------------

protocol ViewModelDelegate : class {
    func reloadUI()
}

// MARK: - View Model Implementation -
//-------------------------------------------------------------

class ViewModel: NSObject {
    
    /// - Tag: ViewModel
    weak var delegate : ViewModelDelegate?
    
    let realm = try! Realm()
    var gnomes: Results<Gnome>?
    
    /*
     This method simulates a request to fetch the frameworks
     */
    func fetchGnomes(with text: String = "") {
        if text == "" {
            gnomes = realm.objects(Gnome.self)
        } else {
            gnomes = realm.objects(Gnome.self).filter("name BEGINSWITH %@", text)
        }
        delegate?.reloadUI()
    }
    
}

