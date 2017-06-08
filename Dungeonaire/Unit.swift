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
    var maxHealth = 10
    
    func healthChanged(by amount: Double) {
        health -= Int(amount)
        if health <= 0 {
            isDefeated = true
            health = 0
        }
    }
    
    func calculateDamageRange() -> Double {
        return 0
    }
    
    func update(dt: TimeInterval) {
        
    }
    
    
    
}
