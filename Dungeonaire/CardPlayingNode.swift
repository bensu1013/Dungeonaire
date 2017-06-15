//
//  CardPlayingNode.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/15/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class CardPlayingNode: SKNode {
    
    var cards = [CardSprite]()
    var cardPos1 = CGPoint()
    var cardPos2 = CGPoint()
    var cardPos3 = CGPoint()
    var deck = SKSpriteNode()
    
    func setVariables(_ node: SKNode) {
        
        
        print("setting variables")
        
        for count in 1...3 {
            if let cardNode = node.childNode(withName: "Card\(count)") as? CardSprite {
                print("individual cards")
                cards.append(cardNode)
            }
        }
        print(cards.count)
        cards[0].cardName = "did it work??!"
        print(cards[0].cardName)
        
    }
    
}

class CardSprite: SKSpriteNode {
    
    var cardName: String? {
        get {
            if let label = childNode(withName: "Name") as? SKLabelNode {
                return label.text
            }
            return nil
        }
        set {
            if let label = childNode(withName: "Name") as? SKLabelNode {
                label.text = newValue
            }
        }
    }
    
    
    
}
