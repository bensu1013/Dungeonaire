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
    var hand: Hand?
    var speed: Int {
        get {
            return unit.stats.dexterity
        }
    }
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
    
    func completeTurn() {
        
        initiative -= turnThreshold
        hand = nil
        
    }
    
    func useCard(_ slot: SkillSlot, target: Unit) {
        if let hand = hand {
            if slot == .first {
                target.healthChanged(by: hand[slot.rawValue].temp)
            }
        }
        
    }
    
    func drawCards() -> Hand {
        let first = unit.deck.popLast()!
        let second = unit.deck.popLast()!
        let third = unit.deck.popLast()!
        hand = [first, second, third]
        return [first, second, third]
    }
    
    //MARK: - Initiative and Turn management
    func initiativeIncrement() {
        if !isDefeated {
            initiative += unit.stats.dexterity
        }
    }
    
    func initiativeStart() {
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



