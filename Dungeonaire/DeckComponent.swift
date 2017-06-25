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
        let newDeck = unit.equipment.getEquipmentCards()
        return shuffle(newDeck)
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





