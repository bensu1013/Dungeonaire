//
//  WarriorClass.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class Warrior: PlayerUnit {
    
    override var maxHealth: Int {
        return 20 + (stats.vitality * 4)
    }
    
    override init() {
        super.init()
        stats.strength = 7
        stats.dexterity = 5
        stats.vitality = 6
        stats.wisdom = 3
        stats.luck = 2
        health = maxHealth
        let weapon = Weapon()
        equipment.weapon = weapon
        let slash = Slash()
        skills.user = self
        skills.activeSkills.append(slash)
        deck = weapon.cards
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    override func calculateDamageRange() -> Double {
        var damage: Double = Double(stats.strength) / 5 + 1
        if let weapon = equipment.weapon {
            damage = Double(weapon.damage * stats.strength) / 5
        }
        return damage
    }
    
}
