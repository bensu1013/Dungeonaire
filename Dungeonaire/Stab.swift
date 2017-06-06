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
        type = .offense
        canMulti = false
        targets = [0,1]
    }
    
    override func modifiedAmount(with base: Double) -> Double {
        return damageMultiplier * base
    }
    
}
