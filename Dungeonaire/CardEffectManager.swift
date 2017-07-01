//
//  CardEffectManager.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/24/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct CardEffectManager {
    
    //methods to run through card and produce proper results based on cards effects
    func activate(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent, completion: @escaping (CardEffect, Bool) -> ()) {
        for effect in card.statusEffects {
            print("do something")
        }
    }
    
    func damageEffect(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent) -> Bool {
        let attackRoll = Int(arc4random_uniform(UInt32(100))) + 1
        
        if target.didDodge(attackRoll) {
            return false
        } else {
            let baseDamage = Int(arc4random_uniform(UInt32(3))) + 2
            target.healthChanged(by: user.unit.stats.physicalModifier + baseDamage)
            return true
        }
    }
    
    func healEffect(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent) {
        let mainStat = card.getAttribute(for: user.unit)
        let baseDamage = Int(arc4random_uniform(UInt32(3))) + 2
        
        target.healthChanged(by: -(mainStat + baseDamage))
    }
    
    func persistentEffect(_ effect: CardEffect, on target: BattleComponent) -> Bool {
        let attackRoll = Int(arc4random_uniform(UInt32(100))) + 1
        
        if target.didResist(attackRoll) {
            return false
        } else {
            target.persistedEffects.append(effect)
            return true
        }
        
    }
    
}


