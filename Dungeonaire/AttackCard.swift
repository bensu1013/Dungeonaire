//
//  AttackCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/30/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

enum AttackCardType: String {
    
    case Slash
    case Bludgeon
    case Stab
    
}

struct AttackCard: SkillCard {
    
    var name: String
    var rank: Int
    var attribute: Attribute
    var isMultiTarget: Bool = false
    var statusEffects = [StatusEffect]()
    
    
    var damageRange = (0,0)
    
    init(type: SkillCardType) {
        let path = Bundle.main.path(forResource: "AttackCardProperties", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        let cardData = dict![type.rawValue] as! [String : Any]
        
        name = type.rawValue
        rank = cardData["Rank"] as! Int
        attribute = Attribute(rawValue: cardData["Attribute"] as! String)!
        isMultiTarget = cardData["MultiTarget"] as! Bool
        let range = cardData["Range"] as! [Int]
        self.damageRange = (range[0], range[1])
        for (effectName, effectRank) in cardData["Effects"] as! [String:Int] {
            if let status = StatusEffectFactory.create(word: effectName, rank: effectRank) {
                self.statusEffects.append(status)
            }
        }
    }
    
    func activateCard(_ owner: Unit, target: Unit) {
        target.battle.healthChanged(by: generateNumber(min: damageRange.0, max: damageRange.1) + owner.stats.physicalModifier)
        
        
    }
    
}








