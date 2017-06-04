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
        
        skills.append(Slash())
    }
    
    override func takeTurn(handler: @escaping (Skill?) -> () ) {
        handler(selectedSkill)
    }
    
    override func update(dt: TimeInterval) {
        if let weapon = equipment.weapon {
            print(weapon.damage)
        }
        print("warrior")
    }
    
    override func selectSkill(_ index: Int) {
        selectedSkill = skills[index]
    }
    
}
