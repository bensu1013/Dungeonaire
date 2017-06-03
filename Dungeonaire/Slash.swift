//
//  Slash.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Slash: Skill {
    
    var damageMultiplier = 1.2
    
    override init() {
        super.init()
        type = .attack
        targets = [0,1]
    }
    
    override func activate(modifier: Double) -> Double {
        return modifier * damageMultiplier
    }
    
}
