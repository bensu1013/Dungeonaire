//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


enum CardEffect: String {
    case Damage
    case DamageArmor
    case Heal
    case GainArmor
    case Slow
    case Stun
}

enum SkillCardType: String {
    case SlapCard
    case SlashCard
    case StabCard
    case BludgeonCard
    case DevastatingSmashCard
    
}

enum MainStat: String {
    case str = "Strength"
    case dex = "Dexterity"
    case vit = "Vitality"
    case wis = "Wisdom"
    case luk = "Luck"
}

struct SkillCard {
    
    var name = ""
    var rank = 1
    var mainStat: MainStat = .luk
    var targetEnemy = true
    var multiTarget = false
    var effects = [CardEffect]()
    var range = (0,0)
    var temp = 4
    
    init(type: SkillCardType) {
        guard let path = Bundle.main.path(forResource: "CardProperties", ofType: "plist") else { return }
        let dict = NSDictionary(contentsOfFile: path)
        let cardData = dict![type.rawValue] as! [String : Any]
        
        name = cardData["Name"] as! String
        rank = cardData["Rank"] as! Int
        mainStat = MainStat.init(rawValue: cardData["MainStat"] as! String)!
        targetEnemy = cardData["TargetEnemy"] as! Bool
        multiTarget = cardData["MultiTarget"] as! Bool
        let range = cardData["Range"] as! [Int]
        self.range = (range[0], range[1])
        for effect in cardData["Effects"] as! [String] {
            self.effects.append(CardEffect(rawValue: effect)!)
        }
    }
    
}
