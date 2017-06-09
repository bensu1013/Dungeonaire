//
//  Character.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Unit {
    
    weak var team: BattleTeam?
    var initiative = 0
    var isDefeated = false
    //Skills should be its own class manager like attributes
    var skills = SkillManager()
    var attributes = Attributes()
    var health = 10
    var maxHealth: Int {
        return 10
    }
    
    func healthChanged(by amount: Double) {
        if !isDefeated {
            health -= Int(amount)
            if health <= 0 {
                isDefeated = true
                health = 0
            }
        }
    }
    
    func calculateDamageRange() -> Double {
        return 0
    }
    
    func update(dt: TimeInterval) {
        
    }
    
    func initiativeIncrement() {
        if !isDefeated {
            initiative += attributes.dexterity
        }
    }
    
    func initiativeReset() {
        if !isDefeated {
            let initBase = Int(arc4random_uniform(UInt32(20)))
            initiative = initBase + attributes.dexterity
        }
    }
    
    func readyForTurn() -> Bool {
        if initiative >= turnThreshold && !isDefeated {
            return true
        }
        return false
    }
    
}
