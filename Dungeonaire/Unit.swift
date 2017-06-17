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
    var baseHealth: Int = 10
    var maxHealth: Int {
        return baseHealth + (stats.vitality * 2)
    }
    
    init() {
        sprite.unit = self
        battle.unit = self
    }
    
    func update(dt: TimeInterval) {
        
    }
    
}
