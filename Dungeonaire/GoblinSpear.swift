//
//  GoblinSpear.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class GoblinSpear: MonsterUnit {
    
    override var maxHealth: Int {
        return 10 + (stats.vitality * 3)
    }
    
    override init() {
        super.init()
        stats.strength = 4
        stats.dexterity = 6
        stats.vitality = 3
        stats.wisdom = 2
        stats.luck = 2
        baseHealth = 15
        battle.health = maxHealth
        battle.team = .team2
        deck = Weapon().cards
    }

    override func update(dt: TimeInterval) {

    }

    
}
