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
    
    var damage = 2
    var cards = [SkillCard]()
    
    //MARK: - temp init to fill card
    init(type: WeaponType) {
        guard let path = Bundle.main.path(forResource: "WeaponProperties", ofType: "plist") else { return }
        let dict = NSDictionary(contentsOfFile: path)
        let weaponData = dict![type.rawValue] as! [String : Any]
        let cards = weaponData["Cards"] as! [String]
        
        for card in cards {
            self.cards.append(SkillCard(type: SkillCardType(rawValue: card)!))
        }
        
        self.damage = weaponData["Damage"] as! Int
        
    }
}
