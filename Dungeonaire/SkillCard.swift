//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


enum CardEffect {
    case damage
    case heal
    case slow
}

enum MainStat: String {
    case str = "Strength"
    case dex = "Dexterity"
    case vit = "Vitality"
    case wis = "Wisdom"
    case luk = "Luck"
}

class SkillCard {
    
    var name = ""
    var rank = 1
    var mainStat: MainStat = .str
    var isFriendly = true
    var effects = [CardEffect]()
    var temp = 4
    
}
