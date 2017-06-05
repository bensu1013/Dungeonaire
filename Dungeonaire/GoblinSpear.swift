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
        health = 234
        
        let stab = Stab()
        stab.user = self
        skills.append(stab)
        
    }
    
    override func activateSkill() {
        if let skill = selectedSkill {
            let damage = skill.activate(modifier: Double(calculateDamageRange()))
            for target in skill.targets {
                self.team?.enemyTeam?.party[target].health -= Int(damage)
            }
        }
    }
    
    override func takeTurn(handler: @escaping (Skill?) -> ()) {
        handler(selectedSkill)
        selectedSkill = nil
    }
    
    override func update(dt: TimeInterval) {

    }
    
    override func selectSkill(at index: Int) {
        //select skill for enemies regardless of index
        selectedSkill = skills[0]
    }
    
    //in case of target selection, add function to choice targets and add to bottom of selectSkill
    
    
    override func calculateDamageRange() -> Int {
        var damage = 0
        damage = attributes.strength
        return damage
    }
    
}
