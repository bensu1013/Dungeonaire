//
//  StatusEffect.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/30/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

typealias StatusDurationPotency = (duration: Int, potency: Int)

enum StatusType: String {
    case Regen  //heals small amount over duration
    case Ward   //increases protection against harmful status effects
    case Quick  //slight increase of speed and dodge
    case Slow   //reduces a units speed (or  lower by 20-30 for duration)
    case Stun   //cancels turns based on duration
    case Poison //damage small amount over duration
}

protocol StatusEffect {
    var name: String {get}
    var rank: Int {get}
    var duration: Int {get}
    
    func activateEffect(_ owner: Unit, target: Unit)
}

struct StunEffect: StatusEffect {
    var name: String = "Stun"
    var rank: Int = 1
    var duration: Int = 1
    
    
    init(rank: Int, duration: Int = 1) {
        self.duration = duration
        self.rank = rank
    }
    
    func activateEffect(_ owner: Unit, target: Unit) {
        if let stunned = target.battle.persistingStatus[.Stun] {
            if duration > stunned.duration {
                if !target.battle.didResist(generateNumber()) &&
                    generateNumber() < (rank * 30 + owner.stats.physicalAccuraryModifier) {
                    target.battle.persistingStatus[.Stun] = (duration, 100 + owner.stats.physicalModifier)
                }
            }
        } else {
            if !target.battle.didResist(generateNumber()) &&
                generateNumber() < (rank * 30 + owner.stats.physicalAccuraryModifier) {
                target.battle.persistingStatus[.Stun] = (duration, 100 + owner.stats.physicalModifier)
            }
        }
    }
    
}

struct RegenEffect: StatusEffect {
    var name: String = "Regen"
    var rank: Int = 1
    var duration: Int = 2
    
    
    init(rank: Int, duration: Int = 2) {
        self.duration = duration
        self.rank = rank
    }
    
    func activateEffect(_ owner: Unit, target: Unit) {
        if let regen = target.battle.persistingStatus[.Regen] {
            if duration > regen.duration {
                target.battle.persistingStatus[.Regen] = (duration, owner.stats.magicalModifier)
            }
        } else {
            target.battle.persistingStatus[.Regen] = (duration, owner.stats.magicalModifier)
        }
    }
}
