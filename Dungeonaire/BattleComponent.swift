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
    var persistingStatus = [StatusType : StatusDurationPotency]()
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
        
        let cardEffectManager = CardEffectManager()
        
//        cardEffectManager.activate(card, for: self, on: target.battle) { effected in
//            //set animation to effect
//            print("used")
//        }
        card.activateCard(self.unit, target: target)
        
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
    
    func didDodge(_ attackRoll: Int) -> Bool {
        var dodgeMod = unit.stats.dodgeModifier
        if let quicken = persistingStatus[.Quick] {
            dodgeMod += quicken.potency
        }
        return attackRoll < dodgeMod
    }
    
    func didResist(_ attackRoll: Int) -> Bool {
        var resistMod = unit.stats.resistModifier
        if let warded = persistingStatus[.Ward] {
            resistMod += warded.potency
        }
        return attackRoll < resistMod
    }
    
    func drawCards() -> Hand {
        let newHand = unit.cards.drawCards()
        hand = newHand
        return newHand
    }
    

    
}

//MARK: - Initiative and Turn management
extension BattleComponent {
    
    func initiativeIncrement() {
        if !isDefeated {
            initiative += unit.stats.dexterity
        }
    }
    
    func initiativeStart() {
        if !isDefeated {
            let initBase = Int(arc4random_uniform(UInt32(30)))
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

