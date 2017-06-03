//
//  WarriorClass.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class Warrior: PlayerUnit {
    
    var selectedSkill: Skill? = nil
    
    override init() {
        super.init()
        attributes.strength = 9
        attributes.dexterity = 5
        attributes.vitality = 6
        attributes.wisdom = 3
        attributes.luck = 2
        
        skills.append(Slash())
    }
    
    override func takeTurn() {
        if let skill = selectedSkill {
            if skill.type == .attack {
                if let weapon = equipment.weapon {
                    
                }
            }
        }
    }
    
    override func update(dt: TimeInterval) {
        if let weapon = equipment.weapon {
            print(weapon.damage)
        }
        print("warrior")
    }
    
    func selectSkill(_ index: Int) {
        selectedSkill = skills[index]
    }
    
}
