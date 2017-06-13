//
//  Slash.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Slash: Skill {
    
    override var multiplier: Double {
        return 1.0 + Double(rank) * 0.3
    }
    
    override init() {
        super.init()
        type = .offense
        targets = [0,1]
    }
    
    override func modifiedAmount(with base: Double) -> Double {
        return multiplier * base
    }
    
}

class SlashCard: SkillCard {
    
    
    
    
}
