//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum SkillCardType: String {
    case Slap
    case Slash
    case Stab
    case Bludgeon
    case DevastatingSmash
}

enum Attribute: String {
    case str = "Strength"
    case dex = "Dexterity"
    case vit = "Vitality"
    case wis = "Wisdom"
    case luk = "Luck"
}

protocol SkillCard {
    var name: String {get}
    var rank: Int {get}
    var attribute: Attribute {get}
    var isMultiTarget: Bool {get}
    var statusEffects: [StatusEffect] {get}
    
    func activateCard(_ owner: Unit, target: Unit)
}

extension SkillCard {
    func getAttribute(for owner: Unit) -> Int {
        switch attribute {
        case .str:
            return owner.stats.strength
        case .dex:
            return owner.stats.dexterity
        case .wis:
            return owner.stats.wisdom
        case .vit:
            return owner.stats.vitality
        case .luk:
            return owner.stats.luck
        }
    }
}








