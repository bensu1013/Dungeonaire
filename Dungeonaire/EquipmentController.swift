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
            deck += [SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlashCard)]
        }
        if let offHand = offHand {
            deck += offHand.cards
        } else {
            deck += [SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlashCard)]
        }
        if let armor = armor {
            deck += armor.cards
        } else {
            deck += [SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlashCard)]
        }
        if let relic = relic1 {
            deck += relic.cards
        } else {
            deck += [SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlapCard)]
        }
        if let relic = relic2 {
            deck += relic.cards
        } else {
            deck += [SkillCard(type: .SlapCard), SkillCard(type: .SlapCard), SkillCard(type: .SlapCard)]
        }
        return deck
    }
    
}
