//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum CardType {
    case damage
    case heal
    case slow
}

class SkillCard {
    
    var rank = 1
    var isFriendly = false
    var type = [CardType]()
    var temp = 4
    
}
