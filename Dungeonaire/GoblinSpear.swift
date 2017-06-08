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
        attributes.strength = 4
        attributes.dexterity = 6
        attributes.vitality = 3
        attributes.wisdom = 2
        attributes.luck = 2
        health = 22
        
        let stab = Stab()
        skills.user = self
        skills.activeSkills.append(stab)
        
    }

    override func update(dt: TimeInterval) {

    }
    //in case of target selection, add function to choose targets and add to bottom of selectSkill
    
    override func calculateDamageRange() -> Double {
        var damage = 0.0
        damage = Double(attributes.strength) / 10 + 1
        return damage
    }
    
}
