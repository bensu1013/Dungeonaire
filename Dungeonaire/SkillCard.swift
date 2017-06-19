//
//  SkillCard.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/12/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


enum CardEffect {
    case damage
    case heal
    case slow
}

enum SkillCardType: String {
    case SlashCard
    
}

enum MainStat: String {
    case str = "Strength"
    case dex = "Dexterity"
    case vit = "Vitality"
    case wis = "Wisdom"
    case luk = "Luck"
}

class SkillCard {
    
    var name = ""
    var rank = 1
    var mainStat: MainStat = .str
    var isFriendly = true
    var effects = [CardEffect]()
    var temp = 4
    var range = (2,4)
    
    init(type: SkillCardType) {
        let path = Bundle.main.path(forResource: "CardProperties", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let cardData = dict![type.rawValue] as! [String : Any]
        
        name = cardData["Name"] as! String
        rank = cardData["Rank"] as! Int
        mainStat = MainStat.init(rawValue: cardData["MainStat"] as! String)!
        isFriendly = cardData["Friendly"] as! Bool
        let range = cardData["Range"] as! [Int]
        self.range = (range[0], range[1])
        
        dump(self)
        
    }
    
}
