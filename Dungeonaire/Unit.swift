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
    
    var name = "Unit"
    var initiative = 0
    var stats = StatsComponent()
    var sprite = SpriteComponent()
    var battle = BattleComponent()
    var cards = CardsComponent()
    var equipment = EquipmentController()
    
    var baseHealth: Int = 10
    var vitHealth: Int = 2
    var maxHealth: Int {
        return baseHealth + (stats.vitality * vitHealth)
    }
    
    init() {
        sprite.unit = self
        battle.unit = self
        cards.unit = self
    }
    
    func update(dt: TimeInterval) {
        
    }
    
}
