//
//  Slash.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Slash: Skill {
    
    let damageMultiplier: Double = 1.3
    
    override init() {
        super.init()
        type = .offense
        canMulti = true
        targets = [0,1]
    }
    
    override func modifiedAmount(with base: Double) -> Double {
        return damageMultiplier * base
    }
    
}
