//
//  Armor.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum ArmorType: String {
    case Leather
}

class Armor: Item {
    
    var name: String = ""
    var defense = 2
    var cards = [SkillCard]()
    
    init(type: ArmorType) {
        guard let path = Bundle.main.path(forResource: "ArmorProperties", ofType: "plist") else { return }
        let dict = NSDictionary(contentsOfFile: path)
        let armorData = dict![type.rawValue] as! [String : Any]
        let cards = armorData["Cards"] as! [String]
        
        for card in cards {
            self.cards.append(AttackCard(type: SkillCardType(rawValue: card)!))
        }
        
        self.defense = armorData["Defense"] as! Int
    }
    
}
