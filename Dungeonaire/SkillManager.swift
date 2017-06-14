//
//  SkillTree.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/7/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum SkillSlot: Int {
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
}

class SkillManager {
    
    weak var user: Unit?
    var allSkills = [Skill]()
    var activeSkills = [Skill]()
    
    init() {
        
    }
    
    //called for skill selection (mainly for user interaction with HUD)
    func select(_ slot: SkillSlot) {
        let skill = activeSkills[slot.rawValue]
        activateSkill(skill: skill)
    }
    
    //send package of data in tuples for skill targets and randomized damage
    func activateSkill(skill: Skill) {
        if skill.type == .offense {
            if let _ = calculateDamage(for: skill) {

            }
        }
    }
    
    //calculates randomize range of skill damage assigned to target
    func calculateDamage(for skill: Skill) -> [TargetedDamage]? {
        guard let user = user else {
            return nil
        }
        var allDamage = [TargetedDamage]()
        for target in skill.targets {
            let damage = user.calculateDamageRange().modify(by: 30.0)
            allDamage.append((target, damage))
        }
        return allDamage
    }
    
    
}
