//
//  BattleComponent.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class BattleComponent {
    
    var unit: Unit!
    var initiative = 0
    var isDefeated = false  {
        didSet {
            initiative = 0
        }
    }
    var health = 10 {
        didSet {
            if health <= 0 {
                health = 0
                isDefeated = true
            }
        }
    }
    
    func initiativeIncrement() {
        if !isDefeated {
            initiative += unit.stats.dexterity
        }
    }
    
    func initiativeReset() {
        if !isDefeated {
            let initBase = Int(arc4random_uniform(UInt32(20)))
            initiative = initBase + unit.stats.dexterity
        }
    }
    
    func readyForTurn() -> Bool {
        if initiative >= turnThreshold && !isDefeated {
            return true
        }
        return false
    }
    
}
