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
        health = maxHealth
        
        let stab = Stab()
        skills.user = self
        skills.activeSkills.append(stab)
        
    }

    override func update(dt: TimeInterval) {

    }
    //in case of target selection, add function to choose targets and add to bottom of selectSkill
    
    override func calculateDamageRange() -> Double {
        var damage = 0.0
        damage = Double(stats.strength) / 5 + 1
        return damage
    }
    
}
