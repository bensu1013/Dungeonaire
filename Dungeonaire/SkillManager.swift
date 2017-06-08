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
        selectedSkill = activeSkills[slot.rawValue]
    }
    
    
    
    
}
