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
        stats.strength = 7
        stats.dexterity = 6
        stats.vitality = 6
        stats.wisdom = 3
        stats.luck = 2
        baseHealth = 20
        vitHealth = 3
        battle.health = maxHealth
        battle.armor = 2
        let weapon = Weapon()
        equipment.weapon = weapon
        battle.team = .team1
        deck = weapon.cards
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    
}
