//
//  File.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Stab: Skill {
    
    var damageMultiplier: Double = 0.9
    
    override init() {
        super.init()
        type = .attack
        targets = [0]
    }
    
    override func activate(modifier: Double) -> Double {
        return modifier * damageMultiplier
    }
    
}
