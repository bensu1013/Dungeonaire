//
//  Skill.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum SkillType {
    case offense
    case defense
}

class Skill {

    var type: SkillType = .offense
    var rank = 1
    var multiplier: Double {
        return 1.0
    }
    //change the target system to have different effectiveness on positions
    //possibly a  [(.position, .effectiveness)]
    var targets = [Int]()
    
    func modifiedAmount(with base: Double) -> Double {
        return 0
    }
    
}
