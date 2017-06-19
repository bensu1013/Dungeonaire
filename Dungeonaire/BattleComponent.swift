//
//  BattleComponent.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum Team {
    case team1, team2
    func getOpposite() -> Team {
        return self == .team1 ? .team2 : .team1
    }
}

class BattleComponent {
    
    var unit: Unit!
    var initiative = 0
    var team: Team = .team1
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
            limitHealth()
        }
    }
    var armor = 0 {
        didSet {
            limitArmor()
        }
    }
    
    private func limitHealth() {
        if health < 0 {
            health = 0
            isDefeated = true
            unit.sprite.isUserInteractionEnabled = false
        } else if health == 0 {
            isDefeated = true
            unit.sprite.isUserInteractionEnabled = false
        } else if health > unit.maxHealth {
            health = unit.maxHealth
        }
    }
    
    private func limitArmor() {
        if armor < 0 {
            armor = 0
        }
    }
    
    func completeTurn() {
        
        initiative -= turnThreshold
        hand = nil
        
    }
    
    func useCard(_ card: SkillCard, target: Unit) {
        
        let stat = getStatFor(card.mainStat)
        var damage = stat + card.temp
        if !card.isFriendly {
            damage = -damage
        }
        target.battle.healthChanged(by: damage)
        
    }
    
    func getStatFor(_ mainStat: MainStat) -> Int {
        switch mainStat {
        case .str:
            return unit.stats.strength
        case .dex:
            return unit.stats.dexterity
        case .vit:
            return unit.stats.vitality
        case .wis:
            return unit.stats.wisdom
        case .luk:
            return unit.stats.luck
        }
    }
    
    func healthChanged(by amount: Int) {
        if !isDefeated {
            if armor < amount {
                health -= amount - armor
                armor = 0
            } else {
                health -= Int(amount)
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



