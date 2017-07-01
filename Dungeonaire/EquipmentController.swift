//
//  EquipmentController.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class EquipmentController {
    
    var weapon: Weapon?
    var offHand: OffHand?
    var armor: Armor?
    var relic1: Relic?
    var relic2: Relic?
    
    func getEquipmentCards() -> [SkillCard] {
        var deck = [SkillCard]()
        if let weapon = weapon {
            deck += weapon.cards
        } else {
            deck += [AttackCard(type: .Slash), AttackCard(type: .Slash), AttackCard(type: .Slash), AttackCard(type: .Slash)]
        }
        if let offHand = offHand {
            deck += offHand.cards
        } else {
            deck += [AttackCard(type: .Slash), AttackCard(type: .Slash), AttackCard(type: .Slash), AttackCard(type: .Slash)]
        }
        if let armor = armor {
            deck += armor.cards
        } else {
            deck += [AttackCard(type: .Bludgeon), AttackCard(type: .Bludgeon), AttackCard(type: .Bludgeon), AttackCard(type: .Bludgeon)]
        }
        if let relic = relic1 {
            deck += relic.cards
        } else {
            deck += [AttackCard(type: .Stab), AttackCard(type: .Stab), AttackCard(type: .Stab)]
        }
        if let relic = relic2 {
            deck += relic.cards
        } else {
            deck += [AttackCard(type: .Stab), AttackCard(type: .Stab), AttackCard(type: .Stab)]
        }
        return deck
    }
    
}
