//
//  Weapon.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum WeaponType: String {
    case Dagger
    case Shortsword
    case Club
    case GreatHammer
}

class Weapon: Item {
    
    var name: String
    var damage = 2
    var cards = [SkillCard]()
    
    //MARK: - temp init to fill card
    init(type: WeaponType) {
        self.name = type.rawValue
        guard let path = Bundle.main.path(forResource: "WeaponProperties", ofType: "plist") else { return }
        let dict = NSDictionary(contentsOfFile: path)
        let weaponData = dict![type.rawValue] as! [String : Any]
        let cards = weaponData["Cards"] as! [String]
        
        for card in cards {
            if let newCard = SkillCardFactory.create(named: card) {
                self.cards.append(newCard)
            }
        }
        
        self.damage = weaponData["Damage"] as! Int
        
    }
}
