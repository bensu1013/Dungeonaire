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
    weak var selectedSkill: Skill?
    var allSkills = [Skill]()
    var activeSkills = [Skill]()
    
    init() {
        
    }
    
    func select(_ slot: SkillSlot) {
        let skill = activeSkills[slot.rawValue]
        selectedSkill = skill
    }
    
    //methods to calculate damage here instead
    
    //send package of data in tuples for skill targets and randomized damage
    func activateSkill() {
        if let skill = selectedSkill {
            if skill.type == .offense {
                if let allDamage = calculateDamage(for: skill) {
                    user?.team?.enemyTeam?.recieveAssault(allDamage)
                }
            }
        }
    }
    
    func calculateDamage(for skill: Skill) -> [(Int, Double)]? {
        guard let user = user else {
            return nil
        }
        var allDamage = [(Int, Double)]()
        for target in skill.targets {
            let damage = user.calculateDamageRange().modify(by: 30.0)
            print(damage)
            allDamage.append((target, damage))
        }
        return allDamage
    }
    
    
}

extension Double {
    
    //returns a smaller number between the percentage given and 100%
    func modify(by percent: Double = 30.0) -> Double {
        var range = percent
        if range < 0 {
            range = 0
        } else if range > 100 {
            range = 100
        }
        let base = 100.0 - range
        let rand = Double(arc4random_uniform(UInt32(range))) + base
        
        return self * rand / 100.0
    }
    
}

