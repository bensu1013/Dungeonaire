//
//  SkillCardFactory.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 7/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct SkillCardFactory {
    
    static func create(named: String) -> SkillCard? {
        if let cardType = SkillCardType(rawValue: named) {
            switch cardType{
            case .Slash:
                return AttackCard(type: cardType)
            case .Stab:
                return AttackCard(type: cardType)
            case .Bludgeon:
                return AttackCard(type: cardType)
            default:
                return nil
            }
        }
        return nil
    }
    
    private static func attackCard(type: SkillCardType) -> SkillCard {
        return AttackCard(type: type)
        
    }
    
    private static func defenseCard(type: SkillCardType) -> SkillCard {
        return DefenseCard(type: type)
    }
    
}
