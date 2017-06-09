//
//  Character.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Unit {
    
    weak var team: BattleTeam?
    var initiative = 0
    var isDefeated = false {
        didSet {
            initiative = 0
        }
    }
    var skills = SkillManager()
    var attributes = Attributes()
    var body = UnitBody()
    var health = 10 {
        didSet {
            if health < 0 {
                health = 0
                isDefeated = true
            }
        }
    }
    var maxHealth: Int {
        return 10 + (attributes.vitality * 2)
    }
    
    func healthChanged(by amount: Double) {
        if !isDefeated {
            health -= Int(amount)
        }
    }
    
    func calculateDamageRange() -> Double {
        return 0
    }
    
    func update(dt: TimeInterval) {
        
    }
    
    //initiative related methods
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
