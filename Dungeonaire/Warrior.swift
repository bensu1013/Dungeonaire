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
        health = 300
        let weapon = Weapon()
        equipment.weapon = weapon
        let slash = Slash()
        slash.user = self
        skills.append(slash)
    }
    
    override func activateSkill() {
        if let skill = selectedSkill {
            let damage = skill.activate(modifier: Double(calculateDamageRange()))
            for target in skill.targets {
                self.team?.enemyTeam?.party[target].health -= Int(damage)
            }
        }
    }
    
    override func takeTurn(handler: @escaping (Skill?) -> () ) {
        handler(selectedSkill)
        selectedSkill = nil
    }
    
    override func update(dt: TimeInterval) {
        
      
    }
    
    override func selectSkill(at index: Int) {
        selectedSkill = skills[index]
    }
    
    override func calculateDamageRange() -> Int {
        var damage = 0
        if let weapon = equipment.weapon {
            damage = weapon.damage * attributes.strength / 10
        }
        return damage
    }
    
}
