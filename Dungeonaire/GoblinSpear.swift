//
//  GoblinSpear.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class GoblinSpear: MonsterUnit {
    
    
    override init() {
        super.init()
        stats.strength = 4
        stats.dexterity = 6
        stats.vitality = 3
        stats.wisdom = 2
        stats.luck = 2
        baseHealth = 10
        vitHealth = 3
        battle.health = maxHealth
        battle.armor = 2
        battle.team = .team2
        equipment.weapon = Weapon(type: .Dagger)
    }

    override func update(dt: TimeInterval) {

    }

    
}
