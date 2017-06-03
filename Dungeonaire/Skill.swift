//
//  Skill.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum SkillType {
    case attack
    case defense
}

class Skill {
    
    var type: SkillType = .attack
    var targets = [Int]()
    
    func activate(modifier: Double) -> Double {
        return 0
    }
    
}
