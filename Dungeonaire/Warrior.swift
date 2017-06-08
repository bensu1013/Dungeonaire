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
        skills.activeSkills.append(slash)
    }
    
    override func activateSkill() {
        if let skill = skills.selectedSkill {
            let damage = skill.modifiedAmount(with: Double(calculateDamageRange()))
            if skill.isMulti {
                self.team?.enemyTeam?.recieveAssault(targets: skill.targets, amount: damage)
            } else {
                
                //user needs to choose target
                let target = Int(arc4random_uniform(UInt32(skill.targets.count)))
                self.team?.enemyTeam?.recieveAssault(targets: [skill.targets[target]], amount: damage)
            }
        }
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    override func calculateDamageRange() -> Int {
        var damage = attributes.strength / 10 + 1
        if let weapon = equipment.weapon {
            damage = weapon.damage * attributes.strength / 10
        }
        return damage
    }
    
}
