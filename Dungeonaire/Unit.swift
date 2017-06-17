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
    var stats = StatsComponent()
    var sprite = SpriteComponent()
    var battle = BattleComponent()
    var deck = [SkillCard]()
    var maxHealth: Int {
        return 10 + (stats.vitality * 2)
    }
    
    init() {
        sprite.unit = self
        battle.unit = self
    }

    func calculateDamageRange() -> Double {
        return 0
    }
    
    func update(dt: TimeInterval) {
        
    }
    
}
