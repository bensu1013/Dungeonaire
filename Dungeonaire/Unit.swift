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
    
    var initiative = 0
    var isDefeated = false {
        didSet {
            initiative = 0
        }
    }
    var stats = StatsComponent()
    var sprite = SpriteComponent()
    var battle = BattleComponent()
    
    var deck = [SkillCard]()
    
    var health = 10 {
        didSet {
            if health < 0 {
                health = 0
                isDefeated = true
            }
        }
    }
    var maxHealth: Int {
        return 10 + (stats.vitality * 2)
    }
    
    init() {
        sprite.unit = self
        battle.unit = self
    }
    
    func healthChanged(by amount: Int) {
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
            initiative += stats.dexterity
        }
    }
    
    func initiativeReset() {
        if !isDefeated {
            let initBase = Int(arc4random_uniform(UInt32(20)))
            initiative = initBase + stats.dexterity
        }
    }
    
    func readyForTurn() -> Bool {
        if initiative >= turnThreshold && !isDefeated {
            return true
        }
        return false
    }
    
}
