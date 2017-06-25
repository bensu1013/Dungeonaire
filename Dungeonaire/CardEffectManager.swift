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
    func activate(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent, completion: @escaping (CardEffect) -> ()) {
        for effect in card.effects {
            
            switch effect {
            case .Damage:
                damageEffect(card, for: user, on: target)
                completion(.Damage)
            case .DamageArmor:
                target.armor -= 10
                completion(.DamageArmor)
            case .Heal:
                healEffect(card, for: user, on: target)
                completion(.Heal)
            case .GainArmor:
                target.armor += 10
                completion(.GainArmor)
            case .Slow:
                target.persistedEffects.append(.Slow)
                completion(.Slow)
            case .Stun:
                target.persistedEffects.append(.Stun)
                completion(.Stun)
            }
        }
    }
    
    func damageEffect(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent) {
        let mainStat = user.getStatFor(card.mainStat)
        let baseDamage = Int(arc4random_uniform(UInt32(card.range.1))) + card.range.0
        
        target.healthChanged(by: mainStat + baseDamage)
    }
    
    func healEffect(_ card: SkillCard, for user: BattleComponent, on target: BattleComponent) {
        let mainStat = user.getStatFor(card.mainStat)
        let baseDamage = Int(arc4random_uniform(UInt32(card.range.1))) + card.range.0
        
        target.healthChanged(by: -(mainStat + baseDamage))
    }
    
}


