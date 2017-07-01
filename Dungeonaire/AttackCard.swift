//
//  AttackCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/30/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

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
        
        name = cardData["Name"] as! String
        rank = cardData["Rank"] as! Int
        attribute = Attribute(rawValue: cardData["Attribute"] as! String)!
        isMultiTarget = cardData["MultiTarget"] as! Bool
        let range = cardData["Range"] as! [Int]
        self.damageRange = (range[0], range[1])
        for effect in cardData["Effects"] as! [String] {
            self.statusEffects.append(StunEffect(rank: 1))
        }
    }
    
    func activateCard(_ owner: Unit, target: Unit) {
        
    }
    
}
