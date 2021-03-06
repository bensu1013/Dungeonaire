//
//  CardPlayingNode.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/15/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

//Handles card displays and animation in the game scene
class CardPlayingNode: SKNode {
    
    var cards = [CardSprite]()
    var cardPos = [CGPoint]()
    var deck = SKSpriteNode()
    var selectedCard: CardSprite?
    
    func setVariables(_ node: SKNode) {
        if let deckNode = node.childNode(withName: "Deck") as? SKSpriteNode {
            deck = deckNode
        }
        for count in 1...3 {
            if let cardNode = node.childNode(withName: "Card\(count)") as? CardSprite {
                cardNode.position = deck.position
                cards.append(cardNode)
            }
            if let cardPosNode = node.childNode(withName: "cardPosition\(count)") {
                cardPos.append(cardPosNode.position)
            }
        }
        
    }
    
    func showCards(with hand: Hand, for team: Team, completion: @escaping () -> () ) {
        var slideCardActions = [SKAction]()
        for x in 0...hand.count - 1 {
            if team == .team1 {
                cards[x].isUserInteractionEnabled = true
            }
            cards[x].skillCard = hand[x]
            let slide = SKAction.run {
                self.cards[x].slide(to: self.cardPos[x])
            }
            slideCardActions.append(slide)
        }
        let completeAction = SKAction.run { completion() }
        slideCardActions.append(completeAction)
        self.run(SKAction.sequence(slideCardActions))
    }
    
    func clearCards() {
        for x in 0...2 {
            cards[x].isUserInteractionEnabled = false
            cards[x].dropReset(to: deck.position)
        }
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
    
    var skillCard: SkillCard? {
        didSet {
            if let card = skillCard {
                cardName = card.name
            } else {
                cardName = nil
            }
        }
    }
    
    var onPressed: ((SkillCard) -> ())?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onPressed!(skillCard!)
    }
    
    func slide(to point: CGPoint) {
        let slide = SKAction.move(to: point, duration: 0.5)
        self.run(slide)
    }
    
    func dropReset(to point: CGPoint) {
        let drop = SKAction.moveBy(x: 0.0, y: -self.frame.height - 100, duration: 0.2)
        let reset = SKAction.move(to: point, duration: 0.0)
        let sequence = SKAction.sequence([drop, reset])
        run(sequence)
    }
    
}
