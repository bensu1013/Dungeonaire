//
//  DeckComponent.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/24/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

private let maxDeckCount = 18

class CardsComponent {
    
    var unit: Unit!
    var deck = [SkillCard]() {
        didSet{
            deck += constructDeck()
        }
    }
    
    func startBattle() {
        deck = constructDeck()
    }
    
    func drawCards() -> Hand {
        let first = deck.popLast()!
        let second = deck.popLast()!
        let third = deck.popLast()!
        return [first, second, third]
    }
    
    func constructDeck() -> [SkillCard] {
        var newDeck = [SkillCard]()
        if deck.count == 0 {
            if let armor = unit.equipment.armor {
                newDeck += armor.cards
            }
            if let weapon = unit.equipment.weapon {
                newDeck += weapon.cards
            }
            newDeck += insertFillerCards(currentCount: newDeck.count)
            newDeck = shuffle(newDeck)
        }
        return newDeck
    }
    
    func insertFillerCards(currentCount: Int) -> [SkillCard] {
        var tempDeck = [SkillCard]()
        for _ in 1...(maxDeckCount - currentCount) {
            tempDeck.append(SkillCard(type: .SlapCard))
        }
        return tempDeck
    }
    
    func shuffle(_ deck: [SkillCard]) -> [SkillCard] {
        var deck = deck
        //Shufflecards here
        for _ in 0...40 {
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            deck.append(deck.remove(at: randomIndex))
        }
        return deck
    }
    
}





