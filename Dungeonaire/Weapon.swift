//
//  Weapon.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Weapon: Item {
    
    var damage = 3
    var cards = [SkillCard(type: .SlashCard), SkillCard(type: .SlashCard)]
    
    //MARK: - temp init to fill card
    override init() {
        for _ in 0...9 {
            cards.append(SkillCard(type: .SlashCard))
        }
    }
}
