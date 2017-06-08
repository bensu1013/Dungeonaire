//
//  WarriorClass.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class Warrior: PlayerUnit {
    

    
    override init() {
        super.init()
        attributes.strength = 7
        attributes.dexterity = 5
        attributes.vitality = 6
        attributes.wisdom = 3
        attributes.luck = 2
        health = 35
        let weapon = Weapon()
        equipment.weapon = weapon
        let slash = Slash()
        skills.user = self
        skills.activeSkills.append(slash)
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    override func calculateDamageRange() -> Double {
        var damage: Double = Double(attributes.strength) / 10 + 1
        if let weapon = equipment.weapon {
            damage = Double(weapon.damage * attributes.strength) / 10
        }
        return damage
    }
    
}
