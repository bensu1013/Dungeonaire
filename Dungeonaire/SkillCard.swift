//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum SkillSlot: Int {
    case first = 0
    case second = 1
    case third = 2
}

enum CardType {
    case damage
    case heal
    case slow
}

class SkillCard {
    
    var rank = 1
    var isFriendly = true
    var type = [CardType]()
    var temp = 4
    
}
