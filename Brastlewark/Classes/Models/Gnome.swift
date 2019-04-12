//
//  Gnome.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Gnome: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var height: Double = 0.0
    @objc dynamic var hair_color: String = ""
    let professions = List<String>()
    let friends = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.thumbnail = json["thumbnail"].stringValue
        self.age = json["age"].intValue
        self.weight = json["weight"].doubleValue
        self.height = json["height"].doubleValue
        self.hair_color = json["hair_color"].stringValue
        self.professions.append(objectsIn: json["professions"].arrayValue.map { $0.stringValue})
        self.friends.append(objectsIn: json["friends"].arrayValue.map { $0.stringValue})
    }
    
}

