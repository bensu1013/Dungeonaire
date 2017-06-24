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
        equipment.weapon = Weapon(type: .Shortsword)
        battle.team = .team1
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    
}
